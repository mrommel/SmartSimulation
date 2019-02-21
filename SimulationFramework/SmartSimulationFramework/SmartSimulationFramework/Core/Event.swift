//
//  Event.swift
//  SmartSimulationFramework
//
//  Created by Michael Rommel on 10.10.18.
//  Copyright © 2018 Michael Rommel. All rights reserved.
//

import Foundation

public class Event: Simulation {

    init(image: UIImage?, name: String, summary: String, category: Category) {

		super.init(
            image: image,
            name: name,
            summary: summary,
            category: category,
            value: 0.0)
	}

	func effects(for global: GlobalSimulation?) -> [Effect] {

		assertionFailure("Subclasses need to implement this method")

		return []
	}
}
