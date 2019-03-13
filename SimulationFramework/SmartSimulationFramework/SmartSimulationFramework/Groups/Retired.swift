//
//  Retired.swift
//  SmartSimulationFramework
//
//  Created by Michael Rommel on 28.02.19.
//  Copyright © 2019 Michael Rommel. All rights reserved.
//

import Foundation

public class Retired: Group {
    
    init() {
        
        super.init(
            identifier: "Retired",
            image: UIImage(named: "retired"),
            name: "Retired",
            summary: "Retirees are people who have reached retirement age (typically 65) and have retired from their jobs. Now that they're no longer working, their main concerns are living well, long, and safely as possible. To this end, their main concerns are having low Violent Crime rates, decent pensions, and a good standard of public health.",
            moodValue: 0.6,
            frequencyValue: 0.1)
    }
    
    override func setup(with global: GlobalSimulation) {
        
        // Retirees can't be commuters, parents, self employed, state employed, or young.
        self.groupFrequenceInfluences.append(GroupFrequenceInfluence(group: global.groups.parents, influence: -1.0))
        self.groupFrequenceInfluences.append(GroupFrequenceInfluence(group: global.groups.young, influence: -1.0))
        //self.groupFrequenceInfluences.append(GroupFrequenceInfluence(group: global.groups.selfEmployee, influence: -1.0))
        //self.groupFrequenceInfluences.append(GroupFrequenceInfluence(group: global.groups.stateEmployee, influence: -1.0))
        
        self.mood.add(simulation: self.mood, formula: "x") // keep self value
        self.frequency.add(simulation: self.frequency, formula: "x") // keep self value
        
        global.groups.add(group: self)
    }
}
