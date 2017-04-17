//
//  NetworkingClient.swift
//  SayWhatYouWill
//
//  Created by ALEXANDRA SALVATORE on 4/15/17.
//  Copyright © 2017 RowOut. All rights reserved.
//

// The networking client wraps Alamo Fire so that we can
// switch our networking implementation whenever without
// having to refactor the whole codebase.

import Foundation
import Alamofire

class NetworkingClient {
    typealias JSONCompletionBlock = (_ response: URLResponse?, _ responseText: String?, _ error: Error?) -> Void
    fileprivate let configuration = URLSessionConfiguration.default
    fileprivate let sessionManager: SessionManager
    
    init() {
        sessionManager = Alamofire.SessionManager(configuration: configuration)
    }
    
    //TODO wrap DataRequest so that request can be managed by httpmanager
    func getRequest(url: URL,
                    parameters: [String: String]?,
                    headers: [String: String]?,
                    completion: @escaping JSONCompletionBlock) -> Any {
        
        return sessionManager.request(url,
                                      method: .get,
                                      parameters: parameters,
                                      headers: headers).responseString { response in
            completion(response.response, response.result.value, response.error)
        }
    }
    
    func cancel(_ request: Any?) {
        if let dataRequest = request as? DataRequest {
            dataRequest.cancel()
        }
    }
}


