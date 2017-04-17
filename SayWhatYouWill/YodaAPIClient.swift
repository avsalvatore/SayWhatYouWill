//
//  YodaAPIClient.swift
//  SayWhatYouWill
//
//  Created by ALEXANDRA SALVATORE on 4/15/17.
//  Copyright © 2017 RowOut. All rights reserved.
//

import Foundation

class YodaAPIClient {
    
    typealias YodaAPICompletion = (_ yodaSays: String?, _ error: Error?) -> Void
    //Move this to APIClientManager when/if we introduce more APIClients
    fileprivate let networkingClient = NetworkingClient()
    fileprivate var currentRequest: Any?  // only want to have one request going at once, for now
    private let baseURL = URL(string: "https://yoda.p.mashape.com/yoda")
    
    let headers: [String: String] = [
        "X-Mashape-Key": "PUw3BV1Q0RmshTXuVcm3BHqDSJqFp1sbB7TjsnINGHpNBSZJBS",
        "Accept": "text/plain"
    ]
    
    func updateRequest(with text: String, completion: YodaAPICompletion?) {
        //TODO check that text is different from text in currentRequest
        guard let yodaURL = baseURL else { return }
        if currentRequest != nil {
            networkingClient.cancel(currentRequest)
        }
        let params = ["sentence": text]
        currentRequest =
            networkingClient.getRequest(url: yodaURL,
                                        parameters: params,
                                        headers: headers) { response, responseText, error in
                                           completion?(responseText, error)
        }
    }
    
}
