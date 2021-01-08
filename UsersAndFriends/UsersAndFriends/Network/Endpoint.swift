import Foundation

struct Endpoint<Response: Decodable> {
    var path: String
    var queryItems = [URLQueryItem]()
}

extension Endpoint {
    func makeRequest() -> URLRequest? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "www.hackingwithswift.com"
        components.path = "/" + path
        components.queryItems = queryItems.isEmpty ? nil : queryItems

        guard let url = components.url else {
            return nil
        }

        return URLRequest(url: url)
    }
}

extension Endpoint {
    static func getUsersAndFriends() -> Self where Response == [User] {
        Endpoint(path: "samples/friendface.json")
    }
}

enum EndpointError: Error {
    case invalidEndpoint(endpoint: String)
}
