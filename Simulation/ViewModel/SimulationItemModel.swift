//
//  SimulationItemModel.swift
//  Simulation
//
//  Created by Michael Rommel on 17.02.19.
//  Copyright © 2019 Michael Rommel. All rights reserved.
//

import Foundation
import SmartSimulationFramework

class SimulationItemModel {
    
    var name: String
    var summary: String
    var category: String
    var value: String
    
    init(simulation: Simulation?) {
        self.name = simulation?.name ?? "-"
        self.summary = simulation?.summary ?? "-"
        self.category = simulation?.category.text ?? "-"
        self.value = simulation?.valueText() ?? "-"
    }
}

extension SimulationItemModel: NameProviderProtocol {
    
    func getName() -> String {
        return self.name
    }
}

extension SimulationItemModel: DescriptionProviderProtocol {
    
    func getDescription() -> String {
        return self.summary
    }
}
