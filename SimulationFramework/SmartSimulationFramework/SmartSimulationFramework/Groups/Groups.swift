//
//  Groups.swift
//  SmartSimulationFramework
//
//  Created by Michael Rommel on 24.10.18.
//  Copyright © 2018 Michael Rommel. All rights reserved.
//

import Foundation

public class Groups {

	public var all: All
	public var conservatives: Conservatives
	public var poor: Poor
	public var religious: Religious

	fileprivate var groups: [Group] = []

	init() {

		self.all = All()
		self.conservatives = Conservatives()
		self.poor = Poor()
		self.religious = Religious()
	}

	func setup(with global: GlobalSimulation) {

		self.all.setup(with: global)
		self.conservatives.setup(with: global)
		self.poor.setup(with: global)
		self.religious.setup(with: global)
	}

	func add(group: Group) {

		self.groups.append(group)
	}

	func calculate() {

		self.groups.forEach { $0.calculate() }
	}

	func push() {

		self.groups.forEach { $0.push() }
	}
}

extension Groups: Sequence {
    
    public struct GroupsIterator: IteratorProtocol {
        
        private var index = 0
        private let groups: [Group]
        
        init(groups: [Group]) {
            self.groups = groups
        }
        
        mutating public func next() -> Group? {
            let group = self.groups[safe: index]
            index += 1
            return group
        }
    }
    
    public func makeIterator() -> GroupsIterator {
        return GroupsIterator(groups: self.groups)
    }
}
