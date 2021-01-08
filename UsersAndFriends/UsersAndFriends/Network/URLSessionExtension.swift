import Foundation

extension URLSession {
    func request<R>(for endpoint: Endpoint<R>,
                 decoder: JSONDecoder = .init(),
                 then handler: @escaping (Result<R, Error>) -> Void) {
        if let request = endpoint.makeRequest() {
            dataTask(with: request) { data, _, error in
                if let data = data,
                   let decodedData = try? decoder.decode(R.self, from: data) {
                    handler(.success(decodedData))
                } else if let error = error {
                    handler(.failure(error))
                } else {
                    handler(.failure(EndpointError.invalidEndpoint(endpoint: endpoint.path)))
                }
            }.resume()
        } else {
            handler(.failure(EndpointError.invalidEndpoint(endpoint: endpoint.path)))
        }
    }
}
