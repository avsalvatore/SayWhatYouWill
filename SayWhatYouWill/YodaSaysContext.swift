//
//  YodaSaysContext.swift
//  SayWhatYouWill
//
//  Created by ALEXANDRA SALVATORE on 4/15/17.
//  Copyright © 2017 RowOut. All rights reserved.
//

import Foundation

class YodaSaysContext {
    fileprivate let apiClient = YodaAPIClient()
    fileprivate let yodaViewModel = YodaSaysViewModel()
    
    fileprivate var responseCache = [String: String]()
}

extension YodaSaysContext: TextManipulator {
    
    var viewModel: TextManipulationViewModel {
       return yodaViewModel
    }
    
    func translate(text: String, completion: TextManipulator.TextManipluatorCompletion?) {
        if let response = responseCache[text] {
            completion?(response, nil)
        } else {
            apiClient.updateRequest(with: text) { [weak self] responseText, error in
                guard let `self` = self else { return }
                if let response = responseText {
                    self.responseCache[text] = response
                }
                completion?(responseText, error)
            }
        }
    }
}
