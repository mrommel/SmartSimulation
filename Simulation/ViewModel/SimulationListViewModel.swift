//
//  SimulationListViewModel.swift
//  simulation
//
//  Created by Michael Rommel on 08.02.19.
//  Copyright © 2019 Michael Rommel. All rights reserved.
//

import Foundation
import SmartSimulationFramework

class SimulationListViewModel: ViewModelType {
    
    static let simulationDetailSegue = R.segue.simulationListViewController.showSimulation

    internal var delegate: ViewModelDelegate?
    var simulationItemModels: [SimulationItemModel] = []
    
    internal var selectedSimulationItemModel: SimulationItemModel?
    
    func bootstrap() {
        self.loadData()
    }
    
    func loadData() {
        delegate?.willLoadData()
        
        Delay.delayed(by: 1) {
            
            self.simulationItemModels = []
            
            if let simulations = GlobalSimulationManager.shared.simulations() {
                for simulation in simulations {
                    self.simulationItemModels.append(SimulationItemModel(simulation: simulation))
                }
            }
            
            DispatchQueue.main.async {
                self.delegate?.didLoadData()
            }
        }
    }
    
    func addSimulation() {
        // self.delegate?.performSegue(named: SimulationListViewModel.simulationDetailSegue.identifier)
    }
    
    func simulationCount() -> Int {
        return self.simulationItemModels.count
    }
    
    func simulation(at index: Int) -> SimulationItemModel? {
        return self.simulationItemModels[index]
    }
    
    func selectSimulation(at index: Int) {
        print("selectSimulation \(index)")
        self.selectedSimulationItemModel = self.simulationItemModels[index]
        self.delegate?.performSegue(named: SimulationListViewModel.simulationDetailSegue.identifier)
    }
}
