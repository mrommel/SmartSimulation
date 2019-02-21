//
//  StaticProperty.swift
//  SmartSimulationFramework
//
//  Created by Michael Rommel on 13.09.18.
//  Copyright © 2018 Michael Rommel. All rights reserved.
//

import Foundation

class StaticProperty: Simulation {

	init(value: Double) {
		super.init(
            image: nil,
            name: "static",
            summary: "",
            category: .static,
            value: value)
	}
}
