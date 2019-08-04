
import Foundation

enum NetworkResponse:String {
    case success
    case authenticationError = "You need to be authenticated first."
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated."
    case serverError = "Internal Server Error"
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
}

enum Result<String>{
    case success
    case failure(String)
}


struct NetworkManager {
    static let environment : NetworkEnvironment = .baseURL
    let router = Router<ECSApi>()
    typealias ServiceResponse = (NSDictionary?, NSError?) -> Void
    
    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String>{
        switch response.statusCode {
        case 200...299: return .success
        case 401...499: return .failure(NetworkResponse.authenticationError.rawValue)
        case 500: return .failure(NetworkResponse.serverError.rawValue)
        case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
        case 600: return .failure(NetworkResponse.outdated.rawValue)
        default: return .failure(NetworkResponse.failed.rawValue)
        }
    }
    

    func req(method: Method, parameters: Parameters, completion: @escaping (_ resopnse: Any?,_ error: String?)->()){
        router.request(.req(method: method, parameters: parameters)) { data, response, error in
            
            if error != nil {
                completion(nil, "Please check your network connection.")
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    
                    let jsonString = String(data: responseData, encoding: String.Encoding.utf8) ?? ""
                    print(jsonString)
                    switch method {
                    case .viewed:

                        let apiResponse = ViewsAPIResponse(JSONString: jsonString)
                        completion(apiResponse,nil)
    
                    }
                    
                case .failure(let networkFailureError):
                    completion(nil, networkFailureError)
                }
            }
        }
    }
    
}



