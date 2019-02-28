//
//  DashboardViewModel.swift
//  Simulation
//
//  Created by Michael Rommel on 19.02.19.
//  Copyright © 2019 Michael Rommel. All rights reserved.
//

import Foundation

class DashboardViewModel: ViewModelType {
    
    var delegate: ViewModelDelegate?
    
    func bootstrap() {
        
        GlobalSimulationManager.shared.eventLog?.delegate = self
        
        self.loadData()
    }
    
    func loadData() {
        
        delegate?.willLoadData()
        
        DispatchQueue.main.async {
            self.delegate?.didLoadData()
        }
    }
}

extension DashboardViewModel {
    
    func turns() -> Int {
        return GlobalSimulationManager.shared.eventLog?.turns.count ?? 0
    }
    
    func turn(in section: Int) -> GlobalSimulationTurn? {
        return GlobalSimulationManager.shared.eventLog?.turns[section]
    }
    
    func events(in section: Int) -> Int {
        return GlobalSimulationManager.shared.eventLog?.turns[section].events.count ?? 0
    }
    
    func event(at indexPath: IndexPath) -> GlobalSimulationEvent? {
        return GlobalSimulationManager.shared.eventLog?.turns[indexPath.section].events[indexPath.row]
    }
}

extension DashboardViewModel: GlobalSimulationEventLogDelegate {
    
    func didAddEvent() {
        self.loadData()
    }
}
