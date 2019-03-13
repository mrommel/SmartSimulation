//
//  Parents.swift
//  SmartSimulationFramework
//
//  Created by Michael Rommel on 28.02.19.
//  Copyright © 2019 Michael Rommel. All rights reserved.
//

import Foundation

public class Parents: Group {
    
    init() {
        
        super.init(
            identifier: "Parents",
            image: UIImage(named: "parents"),
            name: "Parents",
            summary: "Parents are citizens who have children. The safety and welfare of their children is a parent's primary concern, so the group advocate for laws and subsidies which help look after the well-being of kids.",
            moodValue: 0.6,
            frequencyValue: 0.25)
    }
    
    override func setup(with global: GlobalSimulation) {
        
        // Parents can't be retired.
        self.groupFrequenceInfluences.append(GroupFrequenceInfluence(group: global.groups.retired, influence: -1.0))
        
        self.mood.add(simulation: self.mood, formula: "x") // keep self value
        self.frequency.add(simulation: self.frequency, formula: "x") // keep self value
        
        global.groups.add(group: self)
    }
}
