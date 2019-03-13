//
//  SituationDetailViewModel.swift
//  Simulation
//
//  Created by Michael Rommel on 13.03.19.
//  Copyright © 2019 Michael Rommel. All rights reserved.
//

import SmartSimulationFramework

class SituationDetailViewModel : DetailViewModel {
    
    init(situation: Situation?) {
        
        super.init(image: situation?.image,
                   name: situation?.name ?? "-",
                   summary: situation?.summary ?? "-",
                   category: situation?.category.text ?? "-",
                   value: situation?.valueText() ?? "-",
                   type: .situation)
        
        if let inputs = situation?.inputs {
            for input in inputs {
                self.inputIdentifiers.append(RelationIdentifier(identifier: input.simulation.identifier, formula: input.formula))
            }
        }
        
        if let outputs = situation?.outputs {
            for output in outputs {
                self.outputIdentifiers.append(RelationIdentifier(identifier: output.simulation.identifier, formula: output.formula))
            }
        }
    }
}
