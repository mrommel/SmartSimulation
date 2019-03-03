//
//  Nobles.swift
//  SmartSimulationFramework
//
//  Created by Michael Rommel on 28.02.19.
//  Copyright © 2019 Michael Rommel. All rights reserved.
//

import Foundation

public class Nobles: Group {
    
    init() {
        
        super.init(image: UIImage(named: "nobles"),
                   name: "Nobles",
                   summary: "",
                   moodValue: 0.8,
                   frequencyValue: 0.05)
    }
    
    override func setup(with global: GlobalSimulation) {
        
        // Nobles are most likely no farmers, but wealthy and religious.
        self.groupFrequenceInfluences.append(GroupFrequenceInfluence(group: global.groups.farmers, influence: -0.2))
        self.groupFrequenceInfluences.append(GroupFrequenceInfluence(group: global.groups.wealthy, influence: 0.5))
        self.groupFrequenceInfluences.append(GroupFrequenceInfluence(group: global.groups.religious, influence: 0.2))
        
        self.mood.add(simulation: self.mood, formula: "x") // keep self value
        self.frequency.add(simulation: self.frequency, formula: "x") // keep self value
        
        global.groups.add(group: self)
    }
}
