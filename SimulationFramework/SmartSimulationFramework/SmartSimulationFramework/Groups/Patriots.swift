//
//  Patriots.swift
//  SmartSimulationFramework
//
//  Created by Michael Rommel on 28.02.19.
//  Copyright © 2019 Michael Rommel. All rights reserved.
//

import Foundation

public class Patriots: Group {
    
    init() {
        
        super.init(image: UIImage(named: "patriots"),
                   name: "Patriots",
                   summary: "Most people claim to be patriots when asked, but there is a small proportion of any population who hold strong views about your countries position in the world and also its defense. Patriots are passionate about putting your country first and keeping an adequate military, even in times of peace.    ",
                   moodValue: 0.6,
                   frequencyValue: 0.1)
    }
    
    override func setup(with global: GlobalSimulation) {
        
        // Patriots are less likely member of ethnic minorities
        self.groupFrequenceInfluences.append(GroupFrequenceInfluence(group: global.groups.ethnicMinorities, influence: -0.2))
        
        self.mood.add(simulation: self.mood, formula: "x") // keep self value
        self.frequency.add(simulation: self.frequency, formula: "x") // keep self value
        
        global.groups.add(group: self)
    }
}
