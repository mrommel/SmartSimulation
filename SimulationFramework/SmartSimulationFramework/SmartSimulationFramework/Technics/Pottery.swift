//
//  Pottery.swift
//  SmartSimulationFramework
//
//  Created by Michael Rommel on 23.10.18.
//  Copyright © 2018 Michael Rommel. All rights reserved.
//

import Foundation

public class Pottery: Technic {

    init() {
        super.init(name: "Pottery", era: .ancient, propability: 0.01)
    }

    override func setup(with simulation: GlobalSimulation) {
        self.add(requirement: simulation.technics.agriculture)

        super.setup(with: simulation)
    }
}
