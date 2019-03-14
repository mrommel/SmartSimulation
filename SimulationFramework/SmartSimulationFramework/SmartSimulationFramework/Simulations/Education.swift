//
//  Education.swift
//  SmartSimulationFramework
//
//  Created by Michael Rommel on 13.10.18.
//  Copyright © 2018 Michael Rommel. All rights reserved.
//

import Foundation

class Education: Simulation {

    init() {

        super.init(
            identifier: "Education",
            image: nil,
            name: "Education",
            summary: "A measurement of the education level of the average citizen. Not only literacy, but numeracy and general understanding of everything from history to IT and science.",
            category: .publicServices,
            value: 0.18)
    }

    override func setup(with global: GlobalSimulation) {

        self.add(simulation: global.policies.primarySchools, formula: "0.1+0.3*x", delay: 8)
        // religious schools - monk schools
        
        // out
        // WorkerProductivity,-0.2+(x*0.4)
        // ViolentCrimeRate,-0.12*(x^4)

        global.simulations.add(simulation: self)
    }
}
