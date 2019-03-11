//
//  Wealthy.swift
//  SmartSimulationFramework
//
//  Created by Michael Rommel on 28.02.19.
//  Copyright © 2019 Michael Rommel. All rights reserved.
//

import Foundation

public class Wealthy: Group {
    
    init() {
        
        super.init(image: UIImage(named: "wealthy"),
                   name: "Wealthy",
                   summary: "",
                   moodValue: 0.8,
                   frequencyValue: 0.05)
    }
    
    override func setup(with global: GlobalSimulation) {
        
        // Wealthy are often also nobles.
        self.groupFrequenceInfluences.append(GroupFrequenceInfluence(group: global.groups.nobles, influence: 0.4))
        
        self.mood.add(simulation: self.mood, formula: "x") // keep self value
        self.mood.add(simulation: global.simulations.highIncome, formula: "-0.25*(x-1)^2") // HighIncome,-0.25*(x-1)^2
        self.frequency.add(simulation: self.frequency, formula: "x") // keep self value
        
        global.groups.add(group: self)
    }
}
