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
        
        delegate?.willLoadData()
        
        DispatchQueue.main.async {
            self.delegate?.didLoadData()
        }
    }
}

extension DashboardViewModel {
    
    func eventCount() -> Int {
        return GlobalSimulationManager.shared.eventLog?.events.count ?? 0
    }
    
    func event(at index: Int) -> GlobalSimulationEvent? {
        return GlobalSimulationManager.shared.eventLog?.events[index]
    }
}

extension DashboardViewModel: GlobalSimulationEventLogDelegate {
    
    func didAddEvent() {
        DispatchQueue.main.async {
            self.delegate?.didLoadData()
        }
    }
}
