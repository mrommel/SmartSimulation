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
    var simulationDetailViewModels: [SimulationDetailViewModel] = []
    
    internal var selectedSimulationDetailViewModel: SimulationDetailViewModel?
    
    func bootstrap() {
        self.loadData()
    }
    
    func loadData() {
        delegate?.willLoadData()
        
        Delay.delayed(by: 0.1) {
            
            self.simulationDetailViewModels = []
            
            if let simulations = GlobalSimulationManager.shared.simulations() {
                for simulation in simulations {
                    self.simulationDetailViewModels.append(SimulationDetailViewModel(simulation: simulation))
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
        return self.simulationDetailViewModels.count
    }
    
    func simulation(at index: Int) -> SimulationDetailViewModel? {
        return self.simulationDetailViewModels[index]
    }
    
    func selectSimulation(at index: Int) {
        print("selectSimulation \(index)")
        self.selectedSimulationDetailViewModel = self.simulationDetailViewModels[index]
        self.delegate?.performSegue(named: SimulationListViewModel.simulationDetailSegue.identifier)
    }
}
