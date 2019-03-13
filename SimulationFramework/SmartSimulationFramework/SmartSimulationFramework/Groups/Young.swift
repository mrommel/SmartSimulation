//
//  Young.swift
//  SmartSimulationFramework
//
//  Created by Michael Rommel on 28.02.19.
//  Copyright © 2019 Michael Rommel. All rights reserved.
//

import Foundation

public class Young: Group {
    
    init() {
        
        super.init(
            identifier: "Young",
            image: UIImage(named: "young"),
            name: "Young",
            summary: "This group represents citizens who are old enough to vote, but still considered young. They will either still be in further education, or have recent memories of school/university so will be more strongly affected by those policies affecting education.    ",
            moodValue: 0.6,
            frequencyValue: 0.2)
    }
    
    override func setup(with global: GlobalSimulation) {
        
        // Youngsters can't be retired.
        self.groupFrequenceInfluences.append(GroupFrequenceInfluence(group: global.groups.retired, influence: -1.0))
        //self.groupFrequenceInfluences.append(GroupFrequenceInfluence(group: global.groups.environmentalist, influence: -0.1))
        
        self.mood.add(simulation: self.mood, formula: "x") // keep self value
        self.frequency.add(simulation: self.frequency, formula: "x") // keep self value
        
        global.groups.add(group: self)
    }
}
