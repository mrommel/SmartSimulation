//
//  Liberals.swift
//  SmartSimulationFramework
//
//  Created by Michael Rommel on 27.02.19.
//  Copyright © 2019 Michael Rommel. All rights reserved.
//

import Foundation

public class Liberals: Group {
    
    init() {
        
        super.init(image: UIImage(named: "liberals"),
                   name: "Liberals",
                   summary: "Liberals are supporters of social freedom. They have a distrust for most forms of authority, support the separation of church and state, and oppose any laws that prevent citizens taking actions of their own or making a free choice in a moral issue, such as consumption of products having a negative impact on health (alcohol, tobacco, drugs) or prostitution.",
                   moodValue: 0.6,
                   frequencyValue: 0.25)
    }
    
    override func setup(with simulation: GlobalSimulation) {
        
        simulation.groups.add(group: self)
    }
}
