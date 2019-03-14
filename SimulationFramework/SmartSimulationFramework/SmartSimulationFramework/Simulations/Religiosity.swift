//
//  Religiosity.swift
//  SmartSimulationFramework
//
//  Created by Michael Rommel on 09.09.18.
//  Copyright © 2018 Michael Rommel. All rights reserved.
//

import Foundation

// https://en.wikipedia.org/wiki/Religiosity
class Religiosity: Simulation {

    init() {
        super.init(
            identifier: "Religiosity",
            image: nil,
            name: "Religiosity",
            summary: "Religiosity is difficult to define, but different scholars have seen this concept as broadly about religious orientations and involvement. It includes experiential, ritualistic, ideological, intellectual, consequential, creedal, communal, doctrinal, moral, and cultural dimensions.",
            category: .religion,
            value: 0.8)
    }

    override func setup(with global: GlobalSimulation) {

        self.add(simulation: StaticProperty(value: 0.8)) // TODO: remove

        global.simulations.add(simulation: self)
    }
}
