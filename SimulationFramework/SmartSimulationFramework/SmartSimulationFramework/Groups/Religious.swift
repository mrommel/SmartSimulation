//
//  Religious.swift
//  SmartSimulationFramework
//
//  Created by Michael Rommel on 19.10.18.
//  Copyright © 2018 Michael Rommel. All rights reserved.
//

import Foundation

public class Religious: Group {

	init() {

		super.init(
            identifier: "Religious",
            image: nil,
            name: "Religious",
            summary: "Although there is a wide range of different religions, most of the larger organized groups can agree on a few basic principles. Religious voters support religious teaching in schools, specialized 'faith' schools, and are also pro marriage. Religious groups may also be concerned by abortion and organ donation, and are unlikely to be pro-science.",
            moodValue: 0.7,
            frequencyValue: 0.2)
	}

	override func setup(with global: GlobalSimulation) {

        // Liberals are 20% less likely to be religious and 10% more likely to be environmentalist.
        self.groupFrequenceInfluences.append(GroupFrequenceInfluence(group: global.groups.religious, influence: -0.2))
        //self.groupFrequenceInfluences.append(GroupFrequenceInfluence(group: global.groups.environmentalist, influence: 0.1))
        
        self.mood.add(simulation: self.mood, formula: "x") // keep self value
        self.frequency.add(simulation: self.frequency, formula: "x") // keep self value
        self.frequency.add(simulation: global.simulations.povertyRate, formula: "0+(0.5*x)")
        
		global.groups.add(group: self)
	}
}
