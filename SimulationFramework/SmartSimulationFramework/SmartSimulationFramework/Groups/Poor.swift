//
//  Poor.swift
//  SmartSimulationFramework
//
//  Created by Michael Rommel on 19.10.18.
//  Copyright © 2018 Michael Rommel. All rights reserved.
//

import Foundation

public class Poor: Group {

	init() {

		super.init(
            identifier: "Poor",
            image: UIImage(named: "poor"),
            name: "Poor",
            summary: "Poor people are naturally far more dependent on welfare payments from the state than anybody else. They may also be worried about unemployment more than most, as they consider their jobs more vulnerable. Poor people also are in favor of any progressive tax system that redistributes money their way, such as taxes on luxury goods.",
            moodValue: 0.6,
            frequencyValue: 0.2)
	}

	override func setup(with global: GlobalSimulation) {

        // Poor people aren't predisposed to any other voter groups.
        // can't be rich ???
        
        self.mood.add(simulation: self.mood, formula: "x") // keep self value
        self.frequency.add(simulation: self.frequency, formula: "x") // keep self value
        
		global.groups.add(group: self)
	}
}
