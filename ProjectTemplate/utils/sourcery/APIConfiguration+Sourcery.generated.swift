// Generated using Sourcery 0.16.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT





internal extension TODO.Internal.Endpoint {
    internal var baseURL: URLConvertible {
        return "https://jsonplaceholder.typicode.com"
    }
    internal var method: HTTPMethod {
        switch self {
            case .todos: return .get
            case .todo: return .get
        }
    }
    internal var path: String {
        switch self {
            case .todos():
                return "/todos"
            case .todo(let id):
                return "/posts/\(id)"
        }
    }
    internal var bodyParameters: Parameters? {
        switch self {
            case .todos: return nil
            case .todo: return nil
        }
    }
}

extension TODO.Internal.Endpoint.ApiClient {
    static func todos() -> Future<Models.TODOResponse> {
        return self.request(.todos())
    }
    static func todo(id: Int) -> Future<Models.TODOPostResponse> {
        return self.request(.todo(id: id))
    }
}

