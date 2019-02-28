//
//  TurnEventViewModel.swift
//  Simulation
//
//  Created by Michael Rommel on 27.02.19.
//  Copyright © 2019 Michael Rommel. All rights reserved.
//

import Foundation

class TurnEventViewModel: ViewModelType {
    
    var delegate: ViewModelDelegate?
    
    func bootstrap() {
        
        self.delegate?.willLoadData()
        self.delegate?.didLoadData()
    }
}
