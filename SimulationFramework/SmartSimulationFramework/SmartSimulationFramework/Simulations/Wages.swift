//
//  Wages.swift
//  SmartSimulationFramework
//
//  Created by Michael Rommel on 11.03.19.
//  Copyright © 2019 Michael Rommel. All rights reserved.
//

import Foundation

public class Wages: Simulation {
    
    init() {
        
        super.init(
            identifier: "Wages",
            image: nil,
            name: "Wages",
            summary: "The average wage level in your country. Wages are generally set by supply and demand, which roughly equates to the labor supply and the state of the economy (GDP). Immigration raises the labor supply, reducing wages, and high unemployment will also put downward pressure on wages. Labor laws, including minimum wages can push wages artificially higher, although this will have side-effects.",
            category: .economy,
            value: 0.5)
    }
    
    override func setup(with global: GlobalSimulation) {
        
        // in
        self.add(simulation: StaticProperty(value: 0.5))
        
        // out
        
        global.simulations.add(simulation: self)
    }
}
