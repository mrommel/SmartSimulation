//
//  PolicyDetailViewModel.swift
//  Simulation
//
//  Created by Michael Rommel on 13.03.19.
//  Copyright © 2019 Michael Rommel. All rights reserved.
//

import SmartSimulationFramework

class PolicyDetailViewModel : DetailViewModel {
    
    let policy: Policy?
    
    init(policy: Policy?) {
        
        self.policy = policy
        
        super.init(image: policy?.image,
                   name: policy?.name ?? "-",
                   summary: policy?.summary ?? "-",
                   category: policy?.category.text ?? "-",
                   value: policy?.valueText() ?? "-",
                   type: .policy)
        
        if let inputs = policy?.inputs {
            for input in inputs {
                self.inputIdentifiers.append(RelationIdentifier(identifier: input.simulation.identifier, formula: input.formula))
            }
        }
        
        if let outputs = policy?.outputs {
            for output in outputs {
                self.outputIdentifiers.append(RelationIdentifier(identifier: output.simulation.identifier, formula: output.formula))
            }
        }
    }
    
    override func detail(at indexPath: IndexPath) -> DetailViewModel? {
        
        if indexPath.section == 1 {
            return self.getOutputRelation(at: indexPath.row)
        }
        
        return nil
    }
    
    override func selectDetail(at indexPath: IndexPath, from context: UIViewController) {
        
        if indexPath.section == 0 && indexPath.row == 3 {
            
            self.router?.showPolicySelection(title: self.name, data: self.policy?.selections, selectedIndex: self.policy?.selectedIndex, onSelect: { newSelection in
                
                self.policy?.selection = newSelection
                self.delegate?.didLoadData()
            }, from: context)
            
        } else {
            super.selectDetail(at: indexPath, from: context)
        }
    }
}
