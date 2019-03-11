//
//  RacialTension.swift
//  SmartSimulationFramework
//
//  Created by Michael Rommel on 11.03.19.
//  Copyright © 2019 Michael Rommel. All rights reserved.
//

import Foundation

public class RacialTension: Simulation {
    
    init() {
        
        super.init(
            image: nil,
            name: "Racial Tension",
            summary: "The degree to which there is unease between different nationalities and cultures. Sudden, uncontrolled immigration can sometimes lead to racial tensions, which can in the worst case, result in violent clashes.    ",
            category: .lawOrder,
            value: 0.0)
    }
    
    override func setup(with global: GlobalSimulation) {
        
        // in
        // self.add(simulation: <#T##Simulation#>) // PoliceForce,0+(0.1*x)
        // self.add(simulation: <#T##Simulation#>) // ArmedPolice,0+(0.25*x)
        
        // out
        // Equality,0-(0.5*x)
        // EthnicMinorities,0-(1*x)
        // ViolentCrimeRate,0+(0.1*x)
        // StreetGangs,0+(0.4*x)
        
        global.simulations.add(simulation: self)
    }
}
