//
//  EthnicMinorities.swift
//  SmartSimulationFramework
//
//  Created by Michael Rommel on 28.02.19.
//  Copyright © 2019 Michael Rommel. All rights reserved.
//

import Foundation

public class EthnicMinorities: Group {
    
    init() {
        
        super.init(
            identifier: "Parents",
            image: UIImage(named: "parents"),
            name: "EthnicMinorities",
            summary: "A group representing everyone who is not in the majority ethnic group for this country. They may be immigrants, or may be born to immigrants, and will have strong views regarding foreign aid and border controls, as well as racial discrimination.",
            moodValue: 0.6,
            frequencyValue: 0.3)
    }
    
    override func setup(with global: GlobalSimulation) {
        
        // member of EthnicMinorities are less likely to be patriots
        self.groupFrequenceInfluences.append(GroupFrequenceInfluence(group: global.groups.patriots, influence: -0.2))
        
        self.mood.add(simulation: self.mood, formula: "x") // keep self value
        self.frequency.add(simulation: self.frequency, formula: "x") // keep self value
        
        global.groups.add(group: self)
    }
}
