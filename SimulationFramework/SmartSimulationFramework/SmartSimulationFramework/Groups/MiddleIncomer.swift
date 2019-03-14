//
//  MiddleIncomer.swift
//  SmartSimulationFramework
//
//  Created by Michael Rommel on 14.03.19.
//  Copyright © 2019 Michael Rommel. All rights reserved.
//

import Foundation

public class MiddleIncomer: Group {
    
    init() {
        
        super.init(
            identifier: "MiddleIncomer",
            image: nil,
            name: "MiddleIncomer",
            summary: "",
            moodValue: 0.8,
            frequencyValue: 0.75)
    }
    
    override func setup(with global: GlobalSimulation) {
        
        // Wealthy are often also nobles.
        self.groupFrequenceInfluences.append(GroupFrequenceInfluence(group: global.groups.nobles, influence: 0.4))
        
        //self.mood.add(simulation: self.mood, formula: "x") // keep self value
        self.mood.add(simulation: global.simulations.middleIncome, formula: "0.5-(1-x)^2") // MiddleIncome,0.5-(1-x)^2
        self.frequency.add(simulation: self.frequency, formula: "x") // keep self value
        
        global.groups.add(group: self)
    }
}
