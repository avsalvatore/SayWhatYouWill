//
//  SelfLoveContext.swift
//  SayWhatYouWill
//
//  Created by ALEXANDRA SALVATORE on 4/17/17.
//  Copyright © 2017 RowOut. All rights reserved.
//

import Foundation

class SelfLoveContext {
    fileprivate let selfLoveViewModel = SelfLoveViewModel()
    
    fileprivate let responses = ["You deserve the best",
                                 "Go after what you want",
                                 "Don't let fools interrupt your grindin'",
                                 "You're so beautiful",
                                 "You have the same number of hours in a day as Beyonce",
                                 "You do You"]
}

extension SelfLoveContext: TextManipulator {
    
    var viewModel: TextManipulationViewModel {
        return selfLoveViewModel
    }
    
    func translate(text: String, completion: TextManipulator.TextManipluatorCompletion?) {
        let index = Int(arc4random_uniform(UInt32(responses.count)))
        completion?(responses[index], nil)
    }
}
