//
//  Policies.swift
//  SmartSimulationFramework
//
//  Created by Michael Rommel on 24.10.18.
//  Copyright © 2018 Michael Rommel. All rights reserved.
//

import Foundation

public class Policies {

    public var primarySchools: PrimarySchools = PrimarySchools()
    public var sewage: Sewage = Sewage()

    fileprivate var policies: [Policy] = []

    init() {

        self.primarySchools = PrimarySchools()
        self.sewage = Sewage()
    }

    func setup(with global: GlobalSimulation) {

        self.primarySchools.setup(with: global)
        self.sewage.setup(with: global)
    }

    func add(policy: Policy) {

        self.policies.append(policy)
    }

    func calculate() {

        self.policies.forEach { $0.calculate() }
    }

    func push() {

        self.policies.forEach { $0.push() }
    }
}

extension Policies: Sequence {

    public struct PoliciesIterator: IteratorProtocol {

        private var index = 0
        private let policies: [Policy]

        init(policies: [Policy]) {
            self.policies = policies
        }

        mutating public func next() -> Policy? {
            let policy = self.policies[safe: index]
            index += 1
            return policy
        }
    }

    public func makeIterator() -> PoliciesIterator {
        return PoliciesIterator(policies: self.policies)
    }
}
