//
//  Farmers.swift
//  SmartSimulationFramework
//
//  Created by Michael Rommel on 27.02.19.
//  Copyright © 2019 Michael Rommel. All rights reserved.
//

import Foundation

public class Farmers: Group {
    
    init() {
        
        super.init(image: UIImage(named: "farmers"),
                   name: "Farmers",
                   summary: "Farmers seem to represent not only agricultural workers but anyone who lives and works in a rural area. Farmers support government subsidies and grants that involve agriculture and oppose any limits on hunting or intrusions of the city into rural land.",
                   moodValue: 0.6,
                   frequencyValue: 0.25)
    }
    
    override func setup(with simulation: GlobalSimulation) {
        
        simulation.groups.add(group: self)
    }
}
