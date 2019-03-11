//
//  GlobalSimulationTurn.swift
//  Simulation
//
//  Created by Michael Rommel on 11.03.19.
//  Copyright © 2019 Michael Rommel. All rights reserved.
//

import Foundation

class GlobalSimulationTurn {
    
    let title: String
    var events: [GlobalSimulationEvent] = []
    
    init(title: String) {
        self.title = title
    }
}
