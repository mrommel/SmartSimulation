//
//  LowIncome.swift
//  SmartSimulationFramework
//
//  Created by Michael Rommel on 11.03.19.
//  Copyright © 2019 Michael Rommel. All rights reserved.
//

import Foundation

public class LowIncome: Simulation {
    
    init() {
        
        super.init(
            identifier: "LowIncome",
            image: nil,
            name: "Poor Discretionary Income",
            summary: "The amount of a poor individual's income that remains after paying for necessities such as food, shelter, clothing, taxes, and debt obligations. A positive value allows saving wealth over time, so people can move out of poverty, and into the middle income group. Raising this significantly improves equality.",
            category: .economy,
            value: 0.0)
    }
    
    override func setup(with global: GlobalSimulation) {
        
        // in
        self.add(simulation: global.simulations.wages, formula: "0+(1*x)") // Wages,0+(1*x)
        
        // out
        // Poor,0.5-(1-x)^4
        // Equality,0.5-(1-x)^4,8
        // CarUsage,0.1*(x^3)
        // BusUsage,0-(0.1*x)
        
        global.simulations.add(simulation: self)
    }
}
