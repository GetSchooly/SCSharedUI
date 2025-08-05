import Combine

public protocol APIClient {
    func request<T: Decodable, U: Encodable>(_
        endpoint: some APIEndpointFinal,
        body: U?
    ) -> AnyPublisher<T, Error>
}

