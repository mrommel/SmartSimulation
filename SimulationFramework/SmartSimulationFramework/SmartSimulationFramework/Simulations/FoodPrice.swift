//
//  FoodSecurity.swift
//  SmartSimulationFramework
//
//  Created by Michael Rommel on 27.09.18.
//  Copyright © 2018 Michael Rommel. All rights reserved.
//

import Foundation

class FoodPrice: Simulation {

    init() {
        super.init(
            identifier: "FoodPrice",
            image: nil, 
            name: "Food Price",
            summary: "The average food price is determined by domestic food production and imports. Growing world population and increasingly resource intensive food production contribute to a higher food price and might ultimately lead to a food price crisis.",
            category: .publicServices,
            value: 0.2)
    }

    override func setup(with global: GlobalSimulation) {

        self.add(simulation: StaticProperty(value: 0.2)) // keep self value
        // different sources of food, stable surplus

        global.simulations.add(simulation: self)
    }
}
