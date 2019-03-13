//
//  Conservatives.swift
//  SmartSimulationFramework
//
//  Created by Michael Rommel on 14.10.18.
//  Copyright © 2018 Michael Rommel. All rights reserved.
//

import Foundation

public class Conservatives: Group {

	init() {
        
		super.init(
            identifier: "Conservatives",
            image: UIImage(named: "conservatives"),
            name: "Conservatives",
            summary: "Conservatives are believers in traditional family values, no sex before marriage, strong policies on law and order and are against the legalization of drugs. They are generally in favor of strong policies on law and order.",
            moodValue: 0.6,
            frequencyValue: 0.25)
	}

	override func setup(with global: GlobalSimulation) {

        // Conservatives are 25% more likely to be religious and 10% less likely to be environmentalist.
        self.groupFrequenceInfluences.append(GroupFrequenceInfluence(group: global.groups.religious, influence: 0.25))
        //self.groupFrequenceInfluences.append(GroupFrequenceInfluence(group: global.groups.environmentalist, influence: -0.1))
        
        self.mood.add(simulation: self.mood, formula: "x") // keep self value
        self.mood.add(simulation: global.simulations.racialTension, formula: "0-(0.5*x)") // Conservatives,0-(0.5*x)
        self.frequency.add(simulation: self.frequency, formula: "x") // keep self value
        
        
        global.groups.add(group: self)
	}
}
