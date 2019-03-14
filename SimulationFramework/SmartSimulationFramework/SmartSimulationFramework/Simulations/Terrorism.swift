//
//  Terrorism.swift
//  SmartSimulationFramework
//
//  Created by Michael Rommel on 11.03.19.
//  Copyright © 2019 Michael Rommel. All rights reserved.
//

import Foundation

public class Terrorism: Simulation {
    
    init() {
        
        super.init(
            identifier: "Terrorism",
            image: nil,
            name: "Terrorism",
            summary: "Violent extremism refers to the beliefs and actions of people who support or use ideologically motivated violence to achieve radical ideological, religious or political views.",
            category: .lawOrder,
            value: 0.0)
    }
    
    override func setup(with global: GlobalSimulation) {
        
        self.add(simulation: global.simulations.racialTension, formula: "1*(x^2)", delay: 4) // RacialTension,1*(x^2),4
        self.add(simulation: global.groups.religious.frequency, formula: "0+(0.2*x)") // Religious_freq,0+(0.2*x)
        
        /*ForeignRelations,1*(1-x)^4,4
        Environment,0.5*(1-x)^2,4
        BorderControls,0-(0.1*x),4
        Curfews,-0.1-(0.3*x)
        DetentionWithoutTrial,-0.05-(0.05*x)
        IntelligenceServices,0-(0.4*x)
        MilitarySpending,0-(0.1*x),4
        PhoneTapping,-0.05-(0.05*x)
        PoliceDrones,-0.1-(0.03*x)
        RacialProfiling,-0.02-(-0.03*x)*/
        
        global.simulations.add(simulation: self)
    }
}
