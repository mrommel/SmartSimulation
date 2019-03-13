//
//  SimulationDetailViewModel.swift
//  Simulation
//
//  Created by Michael Rommel on 13.03.19.
//  Copyright © 2019 Michael Rommel. All rights reserved.
//

import SmartSimulationFramework

class SimulationDetailViewModel : DetailViewModel {
    
    init(simulation: Simulation?) {
        
        super.init(image: simulation?.image, name: simulation?.name ?? "-", summary: simulation?.summary ?? "-", category: simulation?.category.text ?? "-", value: simulation?.valueText() ?? "-", type: .simulation)
        
        if let inputs = simulation?.inputs {
            for input in inputs {
                self.inputIdentifiers.append(RelationIdentifier(identifier: input.simulation.identifier, formula: input.formula))
            }
        }
        
        if let outputs = simulation?.outputs {
            for output in outputs {
                self.outputIdentifiers.append(RelationIdentifier(identifier: output.simulation.identifier, formula: output.formula))
            }
        }
    }
}
