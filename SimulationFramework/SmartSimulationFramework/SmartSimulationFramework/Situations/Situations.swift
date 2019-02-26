//
//  Situations.swift
//  SmartSimulationFramework
//
//  Created by Michael Rommel on 24.10.18.
//  Copyright © 2018 Michael Rommel. All rights reserved.
//

import Foundation

public class Situations {

	public var homelessness: Homelessness

	fileprivate var situations: [Situation] = []

	init() {

		self.homelessness = Homelessness()
	}

	func setup(with global: GlobalSimulation) {

		self.homelessness.setup(with: global)
	}

	func add(situation: Situation) {

		self.situations.append(situation)
	}

	func calculate() {

		self.situations.forEach { $0.calculate() }
	}

	func push() {

		self.situations.forEach { $0.push() }
	}
}

extension Situations: Sequence {

	public struct SituationsIterator: IteratorProtocol {

		private var index = 0
		private let situations: [Situation]

		init(situations: [Situation]) {
			self.situations = situations
		}

        mutating public func next() -> Situation? {
			let situation = self.situations[safe: index]
			index += 1
			return situation
		}
	}

    public func makeIterator() -> SituationsIterator {
		return SituationsIterator(situations: self.situations)
	}
}
