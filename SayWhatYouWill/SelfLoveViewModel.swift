//
//  SelfLoveViewModel.swift
//  SayWhatYouWill
//
//  Created by ALEXANDRA SALVATORE on 4/17/17.
//  Copyright © 2017 RowOut. All rights reserved.
//

import Foundation
import UIKit

class SelfLoveViewModel {
    
}

extension SelfLoveViewModel: TextManipulationViewModel {
    var backgroundImage: UIImage? {
        return UIImage(named: "yodaCartoon")
    }
    
    var outputType: OutputType {
        return .text
    }
    
    var inputPlaceholder: String {
        return "What're you thinking today?"
    }
    
    var errorMessage: String {
        return "Sorry! Something went wrong on our end, but don't sweat the small stuff"
    }
    
    var introMessage: String {
        return "Welcome to Self Love"
    }
}
