//
//  Situation.swift
//  SmartSimulationFramework
//
//  Created by Michael Rommel on 19.10.18.
//  Copyright © 2018 Michael Rommel. All rights reserved.
//

import Foundation

public protocol SituationDelegate: class {
	func start(situation: Situation?)
	func end(situation: Situation?)
}

public class Situation: Simulation {

	public var startMessage: String
	var startTrigger: Double
	public var endMessage: String
	var endTrigger: Double

	var enabled: Bool = false

	weak var delegate: SituationDelegate?

    init(identifier: String, name: String, summary: String, startMessage: String, startTrigger: Double, endMessage: String, endTrigger: Double, category: Category) {

		self.startMessage = startMessage
		self.startTrigger = startTrigger

		self.endMessage = endMessage
		self.endTrigger = endTrigger

		super.init(
            identifier: identifier,
            image: nil,
            name: name,
            summary: summary,
            category: category,
            value: 0)
	}

	override func setup(with global: GlobalSimulation) {
		self.delegate = global
		global.situations.add(situation: self)
	}

	override func push() {

		// hysterese
		if !enabled && self.stashedValue >= self.startTrigger {
			// start situation
			self.enabled = true
			self.delegate?.end(situation: self)
		} else if enabled && self.stashedValue <= self.endTrigger {
			// end situation
			self.enabled = false
			self.delegate?.start(situation: self)
		}

		self.push(value: self.enabled ? 1.0 : 0.0)
	}
}
