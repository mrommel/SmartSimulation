//
//  Groups.swift
//  SmartSimulationFramework
//
//  Created by Michael Rommel on 24.10.18.
//  Copyright © 2018 Michael Rommel. All rights reserved.
//

import Foundation

/// linked: P+M+W =100%
/// linked: Lib+Con =100%
/// linked: Soc+Cap =100%
/// All =100%
public class Groups {

	public var all: All
	public var conservatives: Conservatives
    public var liberals: Liberals
	public var poor: Poor
	public var religious: Religious
    public var farmers: Farmers
    public var retired: Retired
    public var parents: Parents
    public var ethnicMinorities: EthnicMinorities
    public var patriots: Patriots
    public var young: Young
    public var nobles: Nobles
    public var wealthy: Wealthy

	fileprivate var groups: [Group] = []

	init() {

		self.all = All()
		self.conservatives = Conservatives()
        self.liberals = Liberals()
		self.poor = Poor()
		self.religious = Religious()
        self.farmers = Farmers()
        self.retired = Retired()
        self.parents = Parents()
        self.ethnicMinorities = EthnicMinorities()
        self.patriots = Patriots()
        self.young = Young()
        self.nobles = Nobles()
        self.wealthy = Wealthy()
	}

	func setup(with global: GlobalSimulation) {

		self.all.setup(with: global)
		self.conservatives.setup(with: global)
        self.liberals.setup(with: global)
		self.poor.setup(with: global)
		self.religious.setup(with: global)
        self.farmers.setup(with: global)
        self.retired.setup(with: global)
        self.parents.setup(with: global)
        self.ethnicMinorities.setup(with: global)
        self.patriots.setup(with: global)
        self.young.setup(with: global)
        self.nobles.setup(with: global)
        self.wealthy.setup(with: global)
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
