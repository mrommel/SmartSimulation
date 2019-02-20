//
//  Technic.swift
//  SmartSimulationFramework
//
//  Created by Michael Rommel on 23.10.18.
//  Copyright © 2018 Michael Rommel. All rights reserved.
//

import Foundation

public protocol TechnicDelegate: class {
	func invented(technic: Technic?)
}

public class Technic {

	public var name: String
	public var era: Era
	public var propability: Double // 0..1 - 0.1 means 10%
	fileprivate var requirements: [Technic] = []
	public var invented: Bool

	weak var delegate: TechnicDelegate?

	init(name: String, era: Era, propability: Double, invented: Bool = false) {
		self.name = name
		self.era = era
		self.propability = propability
		self.invented = invented
	}

	func add(requirement: Technic) {

		self.requirements.append(requirement)
	}

	func setup(with simulation: GlobalSimulation) {

		self.delegate = simulation
		simulation.technics.add(technic: self)
	}

	func evaluate() {

		if self.invented {
			return
		}

		// check if all requirements are valid
		self.requirements.forEach { if !$0.invented { return } }

		// random number
		if Double.random(minimum: 0.0, maximum: 1.0) < propability {
			self.invented = true

			// inform ui
			self.delegate?.invented(technic: self)
		}
	}
}
