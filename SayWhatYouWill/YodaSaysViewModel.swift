//
//  YodaSaysViewModel.swift
//  SayWhatYouWill
//
//  Created by ALEXANDRA SALVATORE on 4/15/17.
//  Copyright © 2017 RowOut. All rights reserved.
//

import Foundation
import UIKit

class YodaSaysViewModel {
    
}

extension YodaSaysViewModel: TextManipulationViewModel {
    var backgroundImage: UIImage? {
        return UIImage(named: "yodaCartoon")
    }
    
    var outputType: OutputType {
        return .text
    }
    
    var inputPlaceholder: String {
        return "Tell Yoda what to say..."
    }
    
    var errorMessage: String {
        return "Sorry! Translate right now, Yoda cannot."
    }
    
    var introMessage: String {
        return "To yoda speak welcome! Yeesssssss"
    }
}
