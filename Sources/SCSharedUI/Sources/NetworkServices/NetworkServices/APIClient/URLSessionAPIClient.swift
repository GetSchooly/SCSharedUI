import Foundation
import Combine
import SCTokens

protocol CodableDataModel: Codable {}

public struct EmptyDataModel: CodableDataModel {}

public final class URLSessionAPIClient: APIClient {

    public init() {}

    public func request<T: Decodable, U: Encodable>(
        _ endpoint: some APIEndpointFinal,
        body: U? = Optional<EmptyDataModel>.none
    ) -> AnyPublisher<T, Error> {

        let url = endpoint.baseURL.appendingPathComponent(endpoint.path)
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)

        if let params = endpoint.parameters, endpoint.method   == .get {
            let queryItems = params
                .filter { $0.value != nil }
                .map { URLQueryItem(name: $0.key, value: "\($0.value!)") }
            components?.queryItems = queryItems
        }

        guard let finalURL = components?.url else {
            return Fail(error: APIError.invalidURL(url: endpoint.path)).eraseToAnyPublisher()
        }

        var request = URLRequest(url: finalURL)
        request.httpMethod = endpoint.method.rawValue
        request.timeoutInterval = 15

        endpoint.headers?.forEach { request.setValue($0.value, forHTTPHeaderField: $0.key) }

        if let body = body {
            do {
                request.httpBody = try JSONEncoder().encode(body)
            } catch {
                return Fail(error: APIError.other(reason: error)).eraseToAnyPublisher()
            }
        }

        return URLSession.shared.dataTaskPublisher(for: request)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse else {
                    Logger.failure("No HTTP response")
                    throw APIError.noResponse
                }

                guard (200...299).contains(httpResponse.statusCode) else {
                    if let error = APIError.fromStatusCode(code: httpResponse.statusCode) {
                        Logger.failure("HTTP Error: \(httpResponse.statusCode) - \(error.localizedDescription)")
                        throw error
                    } else {
                        let json = (try? JSONSerialization.jsonObject(with: data)) as? [String: AnyHashable]
                        if let message = json?["meta"] as? [String: AnyHashable],
                           let msg = message["successMessage"] as? String {
                            Logger.failure("Server Error: \(msg)")
                            throw APIError.serverError(reason: msg)
                        }
                        Logger.failure("Unknown server error for status code: \(httpResponse.statusCode)")
                        throw APIError.unknown
                    }
                }
                return data
            }
            .tryMap { data in
                do {
                    return try JSONDecoder().decode(T.self, from: data)
                } catch let DecodingError.dataCorrupted(context) {
                    Logger.failure("Data corrupted: \(context.debugDescription) at path: \(context.codingPath)")
                    Logger.failure("Raw JSON: \(String(data: data, encoding: .utf8) ?? "N/A")")
                    throw DecodingError.dataCorrupted(context)
                } catch let DecodingError.keyNotFound(key, context) {
                    Logger.failure("Missing key: \(key.stringValue) at path: \(context.codingPath)")
                    Logger.failure("Raw JSON: \(String(data: data, encoding: .utf8) ?? "N/A")")
                    throw DecodingError.keyNotFound(key, context)
                } catch let DecodingError.typeMismatch(type, context) {
                    Logger.failure("Type mismatch for type \(type) at path: \(context.codingPath)")
                    Logger.failure("Debug description: \(context.debugDescription)")
                    Logger.failure("Raw JSON: \(String(data: data, encoding: .utf8) ?? "N/A")")
                    throw DecodingError.typeMismatch(type, context)
                } catch let DecodingError.valueNotFound(value, context) {
                    Logger.failure("Value not found for \(value) at path: \(context.codingPath)")
                    Logger.failure("Raw JSON: \(String(data: data, encoding: .utf8) ?? "N/A")")
                    throw DecodingError.valueNotFound(value, context)
                } catch {
                    Logger.failure("Unknown decoding error: \(error.localizedDescription)")
                    Logger.failure("Raw JSON: \(String(data: data, encoding: .utf8) ?? "N/A")")
                    throw error
                }
            }
            .handleEvents(
                receiveOutput: { _ in
                    Logger.success("Successfully decoded \(T.self)")
                }
            )
            .eraseToAnyPublisher()
    }
}
