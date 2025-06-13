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

                if let json = try? JSONSerialization.jsonObject(with: data, options: []) {
                    print("Response JSON: \(json)")
                }

                if let httpResponse = response as? HTTPURLResponse {
                    guard (200...299).contains(httpResponse.statusCode) else {
                        if let error = APIError.fromStatusCode(code: httpResponse.statusCode) {
                            throw error
                        } else {
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
