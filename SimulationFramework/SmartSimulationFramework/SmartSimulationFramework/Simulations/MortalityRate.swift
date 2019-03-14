//
//  MortalityRate.swift
//  SmartSimulationFramework
//
//  Created by Michael Rommel on 14.09.18.
//  Copyright © 2018 Michael Rommel. All rights reserved.
//

import Foundation

// https://en.wikipedia.org/wiki/Mortality_rate
class MortalityRate: Simulation {

    init() {
        super.init(
            identifier: "MortalityRate",
            image: nil,
            name: "Mortality Rate",
            summary: "Mortality rate, or death rate, is a measure of the number of deaths (in general, or due to a specific cause) in a particular population, scaled to the size of that population, per unit of time.",
            category: .core,
            value: 0.5) // 0..<10
    }

    override func setup(with global: GlobalSimulation) {

        self.add(simulation: StaticProperty(value: 0.5)) // keep self value
        self.add(simulation: global.simulations.health, formula: "-0.3*x")
        self.add(simulation: global.simulations.foodPrice, formula: "0.5*x") // foodsecurity reduces mortality

        global.simulations.add(simulation: self)
    }
}
