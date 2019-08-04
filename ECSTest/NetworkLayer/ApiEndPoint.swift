
import Foundation

public enum Method: String {
    case viewed = "viewed/1.json"
}

enum NetworkEnvironment {
    case baseURL
    case production
    case serverURL
}

public enum ECSApi {
    case req(method: Method,parameters:Parameters)
}

extension ECSApi: EndPointType {
    
    var environmentBaseURL : String {
        switch NetworkManager.environment {
        case .production: return ""
        case .baseURL: return "https://api.nytimes.com/svc/mostpopular/v2/"
        case .serverURL: return ""
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .req(let parm):
            return parm.method.rawValue
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
 
        default:
            return .get
        }
    }
    
    var task: HTTPTask {
        switch self {
            
        case .req(let parameters):
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: parameters.parameters)
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}
