//
//  Population.swift
//  SmartSimulationFramework
//
//  Created by Michael Rommel on 27.09.18.
//  Copyright © 2018 Michael Rommel. All rights reserved.
//

import Foundation

// https://en.wikipedia.org/wiki/Population
class Population: Simulation {

    init() {
        super.init(
            identifier: "Population",
            image: UIImage(named: "population"),
            name: "Population",
            summary: "Population refers to a collection of humans. Demography is a social science which entails the statistical study of human populations. Population in simpler terms is the number of people in a city or town, region, country or world; population is usually determined by a process called census (a process of collecting, analyzing, compiling and publishing data)",
            category: .core,
            value: 1000.0)
    }

    override func setup(with global: GlobalSimulation) {
        self.add(simulation: global.simulations.population, formula: "x") // keep self value
        self.add(simulation: global.simulations.birthRate, formula: "0.02*x*v")
        self.add(simulation: global.simulations.mortalityRate, formula: "-0.02*x*v")

        global.simulations.add(simulation: self)
    }

    override func valueText() -> String {
        return "\(self.value().format(with: ".0")) People"
    }
}
