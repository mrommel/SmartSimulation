//
//  All.swift
//  SmartSimulationFramework
//
//  Created by Michael Rommel on 19.10.18.
//  Copyright © 2018 Michael Rommel. All rights reserved.
//

import Foundation

public class All: Group {

	init() {

		super.init(
            identifier: "All",
            image: nil,
            name: "All",
            summary: "A general group representing the interests of society as a whole, with opinions not related to a particular age group, gender or occupation.",
            moodValue: 0.7,
            frequencyValue: 1.0)
	}

	override func setup(with global: GlobalSimulation) {

        self.mood.add(simulation: self.mood, formula: "x") // keep self value
        self.frequency.add(simulation: StaticProperty(value: 1.0))
        
		global.groups.add(group: self)
	}
}
