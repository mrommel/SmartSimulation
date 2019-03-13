//
//  HighIncome.swift
//  SmartSimulationFramework
//
//  Created by Michael Rommel on 11.03.19.
//  Copyright © 2019 Michael Rommel. All rights reserved.
//

import Foundation

public class HighIncome: Simulation {
    
    init() {
        
        super.init(
            identifier: "HighIncome",
            image: nil,
            name: "Wealthy Discretionary Income",
            summary: "The amount of a wealthy individual's income that remains after paying for necessities such as food, shelter, clothing, taxes, and debt obligations. A positive value allows saving or investing wealth over time.",
            category: .economy,
            value: 0.0)
    }
    
    override func setup(with global: GlobalSimulation) {
        
        // in
        self.add(simulation: global.simulations.wages, formula: "0.8+(0.2*x)") // Wages,0.8+(0.2*x)
        
        // out
        // Equality,0.25-(x^2),8
        // AirTravel,0.3*(x^2)
        
        global.simulations.add(simulation: self)
    }
}
