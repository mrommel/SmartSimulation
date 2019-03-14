//
//  MiddleIncome.swift
//  SmartSimulationFramework
//
//  Created by Michael Rommel on 11.03.19.
//  Copyright © 2019 Michael Rommel. All rights reserved.
//

import Foundation

public class MiddleIncome: Simulation {
    
    init() {
        
        super.init(
            identifier: "MiddleIncome",
            image: nil,
            name: "Middle Discretionary Income",
            summary: "The amount of a middle-class individual's income that remains after paying for necessities such as food, shelter, clothing, taxes, and debt obligations. A positive value allows saving or investing wealth over time.",
            category: .economy,
            value: 0.0)
    }
    
    override func setup(with global: GlobalSimulation) {
        
        // in
        self.add(simulation: global.simulations.wages, formula: "0.2+(0.6*x)") // Wages,0.2+(0.6*x)
        
        // out
        // CarUsage,0.2*(x^3)
        // AirTravel,0.1*(x^3)
        
        global.simulations.add(simulation: self)
    }
}
