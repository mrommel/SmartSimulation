//
//  Group.swift
//  SmartSimulationFramework
//
//  Created by Michael Rommel on 14.10.18.
//  Copyright © 2018 Michael Rommel. All rights reserved.
//

import UIKit

struct GroupFrequenceInfluence {
    
    let group: Group?
    let influence: Double
}

public class Group {

    public let identifier: String
    public let image: UIImage?
	public let name: String
	public let summary: String

	public var mood: Simulation
	public var frequency: Simulation
    
    var groupFrequenceInfluences: [GroupFrequenceInfluence] = []

    init(identifier: String, image: UIImage?, name: String, summary: String, moodValue: Double, frequencyValue: Double) {

        self.identifier = identifier
        self.image = image
		self.name = name
		self.summary = summary

        self.mood = Simulation(identifier: "\(self.identifier)_mood", image: image, name: "\(self.name) mood", summary: "", category: .groups, value: moodValue)
        self.frequency = Simulation(identifier: "\(self.identifier)_freq", image: image, name: "\(self.name) freq", summary: "", category: .groups, value: frequencyValue)
	}

	func calculate() {

		self.mood.calculate()
		self.frequency.calculate()
	}

	func push() {

		self.mood.push()
		self.frequency.push()
	}
    
    func influencedFrequency(by groups: [Group]) -> Double {
        
        var frequencyValue = self.frequency.value()
        
        for groupFrequenceInfluence in self.groupFrequenceInfluences {
            for group in groups {
                if group.name == groupFrequenceInfluence.group?.name {
                    frequencyValue += groupFrequenceInfluence.influence
                }
            }
        }
        
        return frequencyValue
    }

	func setup(with simulation: GlobalSimulation) {
		assertionFailure("Subclasses need to implement this method")
	}
}

extension Group: CustomDebugStringConvertible {
    
    public var debugDescription: String {
        return "Group(name: \(self.name))"
    }
}
