//
//  GroupListViewModel.swift
//  Simulation
//
//  Created by Michael Rommel on 25.02.19.
//  Copyright © 2019 Michael Rommel. All rights reserved.
//

import Foundation

class GroupListViewModel: ViewModelType {
    
    var delegate: ViewModelDelegate?
    
    var groupDetailViewModels: [GroupDetailViewModel] = []
    
    func bootstrap() {
        self.delegate?.willLoadData()
        
        Delay.delayed(by: 0.1) {
        
            self.groupDetailViewModels = []
            
            if let groups = GlobalSimulationManager.shared.groups() {
                for group in groups {
                    self.groupDetailViewModels.append(GroupDetailViewModel(group: group))
                }
            }
            
            DispatchQueue.main.async {
                self.delegate?.didLoadData()
            }
        }
    }
    
    func groupCount() -> Int {
        
        return self.groupDetailViewModels.count
    }
    
    func group(at indexPath: IndexPath) -> GroupDetailViewModel {
        
        return self.groupDetailViewModels[indexPath.row]
    }
}
