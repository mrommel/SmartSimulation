//
//  EventDetailViewModel.swift
//  Simulation
//
//  Created by Michael Rommel on 14.03.19.
//  Copyright © 2019 Michael Rommel. All rights reserved.
//

import SmartSimulationFramework

class EventDetailViewModel : DetailViewModel {
    
    init(event: Event?) {
        
        super.init(image: event?.image,
                   name: event?.name ?? "-",
                   summary: event?.summary ?? "-",
                   category: event?.category.text ?? "-",
                   value: event?.valueText() ?? "-",
                   type: .event)
        
        if let inputs = event?.inputs {
            for input in inputs {
                self.inputIdentifiers.append(RelationIdentifier(identifier: input.simulation.identifier, formula: input.formula))
            }
        }
        
        if let outputs = event?.outputs {
            for output in outputs {
                self.outputIdentifiers.append(RelationIdentifier(identifier: output.simulation.identifier, formula: output.formula))
            }
        }
    }
}
