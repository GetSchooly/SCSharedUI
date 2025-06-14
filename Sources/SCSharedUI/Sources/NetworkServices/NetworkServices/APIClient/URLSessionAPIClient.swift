import Foundation
import Combine

public class URLSessionAPIClient<EndpointType: APIEndpointFinal>: APIClient {

    public init() {}

    public func request<T: Decodable, U: Encodable>(_ endpoint: EndpointType, body: U) -> AnyPublisher<T, Error> {
        let url = endpoint.baseURL.appendingPathComponent(endpoint.path)
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue

        endpoint.headers?.forEach { request.addValue($0.value, forHTTPHeaderField: $0.key) }

        do {
            let jsonData = try JSONEncoder().encode(body)
            request.httpBody = jsonData
        } catch {
            return Fail<T, Error>(error: APIError.other(reason: error)).eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: request)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .tryMap { data, response -> Data in

                guard let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []) else {
                    throw APIError.unknown
                }
                print("Response JSON: \(jsonObject)")

                if let httpResponse = response as? HTTPURLResponse {
                    guard (200...299).contains(httpResponse.statusCode) else {
                        if let error = APIError.fromStatusCode(code: httpResponse.statusCode) {
                            throw error
                        } else {
                            if let obj = jsonObject as? [String: AnyHashable],
                               let meta = obj["meta"] as? [String: AnyHashable],
                                let messgae = meta["successMessage"] as? String,
                                !messgae.isEmpty {
                                throw APIError.serverError(reason: messgae)
                            }
                            throw APIError.unknown
                        }
                    }
                    return data
                } else {
                    throw APIError.noResponse
                }
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
