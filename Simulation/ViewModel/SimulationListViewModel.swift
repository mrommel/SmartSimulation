//
//  SimulationListViewModel.swift
//  simulation
//
//  Created by Michael Rommel on 08.02.19.
//  Copyright © 2019 Michael Rommel. All rights reserved.
//

import Foundation
import SmartSimulationFramework

struct SimulationItemModel {
    
    var name: String
    
    init(simulation: Simulation?) {
        name = simulation?.name ?? ""
    }
}

class SimulationListViewModel: ViewModelType {
    
    static let simulationDetailSegue = "showSimulation"

    internal var delegate: ViewModelDelegate?
    var itemCount = 0
    
    func bootstrap() {
        self.loadData()
    }
    
    func loadData() {
        delegate?.willLoadData()
        
        Delay.delayed(by: 5) {
            DispatchQueue.main.async {

                print("abc * 5")
                self.itemCount = 5
                
                self.delegate?.didLoadData()
            }
        }
    }
    
    func addSimulation() {
        self.delegate?.performSegue(named: SimulationListViewModel.simulationDetailSegue)
    }
    
    func simulationCount() -> Int {
        return self.itemCount
    }
    
    func simulation(at index: Int) -> SimulationItemModel? {
        
        return SimulationItemModel(simulation: Simulation(name: "abc"))
    }
}
