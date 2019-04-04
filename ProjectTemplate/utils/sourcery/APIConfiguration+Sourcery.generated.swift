// Generated using Sourcery 0.16.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT





import Foundation

internal extension TODO.Internal.Endpoint {
    var baseURL: URLConvertible {
        return "https://jsonplaceholder.typicode.com"
    }
    var method: HTTPMethod {
        switch self {
            case .todos: return .get
            case .todo: return .get
        }
    }
    var path: String {
        switch self {
            case .todos:
                return "/todos"
            case .todo(let id):
                return "/posts/\(id)"
        }
    }
    var queryItems: [URLQueryItem] {
        switch self {
			case .todos: return []
			case .todo: return []
        }
    }
    var bodyParameters: Parameters? {
        switch self {
            case .todos: return nil
            case .todo: return nil
        }
    }
}

extension TODO.Internal.Endpoint.ApiClient {
    static func todos() -> Future<Models.TODOResponse> {
        return self.request(.todos)
    }
    static func todo(id: Int) -> Future<Models.TODOPostResponse> {
        return self.request(.todo(id: id))
    }
}

