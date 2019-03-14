//
//  Equality.swift
//  SmartSimulationFramework
//
//  Created by Michael Rommel on 14.03.19.
//  Copyright © 2019 Michael Rommel. All rights reserved.
//

import Foundation

public class Equality: Simulation {
    
    init() {
        
        super.init(
            identifier: "Equality",
            image: nil,
            name: "Equality",
            summary: "",
            category: .welfare,
            value: 0.5)
    }
    
    override func setup(with global: GlobalSimulation) {
        
        // in
        //self.add(simulation: StaticProperty(value: 0.5))
        self.add(simulation: global.simulations.povertyRate, formula: "0-(x*0.1)")
        self.add(simulation: global.simulations.racialTension, formula: "0-(0.5*x)")
        self.add(simulation: global.simulations.lowIncome, formula: "0.5-(1-x)^4", delay: 8)
        self.add(simulation: global.simulations.middleIncome, formula: "-0.2+(0.4*x)", delay: 8)
        
        // out
    
        global.simulations.add(simulation: self)
    }
}
