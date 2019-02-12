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
    var itemCount = 0
    
    func bootstrap() {
        self.loadData()
    }
    
    private func loadData() {
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
        self.delegate?.performSegue(named: "")
    }
    
    func simulationCount() -> Int {
        return self.itemCount
    }
    
    func simulation(at index: Int) -> SimulationItemModel? {
        
        return SimulationItemModel(simulation: Simulation(name: "abc"))
    }
}
