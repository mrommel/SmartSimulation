//
//  Poverty.swift
//  SmartSimulationFramework
//
//  Created by Michael Rommel on 13.10.18.
//  Copyright © 2018 Michael Rommel. All rights reserved.
//

import Foundation

class Poverty: Simulation {

    init() {

        super.init(
            identifier: "Poverty",
            image: nil,
            name: "Poverty",
            summary: "The poverty threshold or poverty line is the minimum level of income deemed adequate in a particular country to meet the basic needs of human survival, including food, clothing, shelter, and healthcare.",
            category: .welfare,
            value: 0.64)
    }

    override func setup(with global: GlobalSimulation) {

        // TODO add inputs
        
        // out
        // CrimeRate,0.41*(x^2),4
        // RacialTension,0+(0.22*x),2
        // Equality,0-(x*0.1)
        // Poor,0-(x*0.5)
        // Farmers,0-(x*0.25)
        // Socialist,-0.35*(x^2)
        // _global_socialism,0.2*(x^5)
        // Religious_freq,0+(0.5*x)

        global.simulations.add(simulation: self)
    }
}
