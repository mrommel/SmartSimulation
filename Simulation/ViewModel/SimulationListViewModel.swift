//
//  SimulationListViewModel.swift
//  simulation
//
//  Created by Michael Rommel on 08.02.19.
//  Copyright © 2019 Michael Rommel. All rights reserved.
//

import Foundation

struct SimulationItemModel {
    
    var name: String
    
    init(simulation: Simulation?) {
        name = simulation?.name ?? ""
    }
}

class SimulationListViewModel: ViewModelType {
    
    internal var delegate: ViewModelDelegate?
    
    func bootstrap() {
        // add logic here
    }
    
    func addSimulation() {
        
    }
    
    func simulationCount() -> Int {
        return 2
    }
    
    func simulation(at index: Int) -> SimulationItemModel? {
        
        return SimulationItemModel(simulation: Simulation(name: "abc"))
    }
}
