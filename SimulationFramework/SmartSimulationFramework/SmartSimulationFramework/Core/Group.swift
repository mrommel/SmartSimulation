//
//  Group.swift
//  SmartSimulationFramework
//
//  Created by Michael Rommel on 14.10.18.
//  Copyright © 2018 Michael Rommel. All rights reserved.
//

import UIKit

public class Group {

    public let image: UIImage?
	public let name: String
	public let summary: String

	public var mood: Simulation
	public var frequency: Simulation

	init(image: UIImage?, name: String, summary: String, moodValue: Double, frequencyValue: Double) {

        self.image = image
		self.name = name
		self.summary = summary

		self.mood = Simulation(image: image, name: "\(self.name) mood", summary: "", category: .groups, value: moodValue)
		self.frequency = Simulation(image: image, name: "\(self.name) freq", summary: "", category: .groups, value: frequencyValue)
	}

	func calculate() {

		self.mood.calculate()
		self.frequency.calculate()
	}

	func push() {

		self.mood.push()
		self.frequency.push()
	}

	func setup(with simulation: GlobalSimulation) {
		assertionFailure("Subclasses need to implement this method")
	}
}
