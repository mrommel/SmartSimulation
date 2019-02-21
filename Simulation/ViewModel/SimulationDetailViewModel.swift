//
//  SimulationDetailViewModel.swift
//  Simulation
//
//  Created by Michael Rommel on 17.02.19.
//  Copyright © 2019 Michael Rommel. All rights reserved.
//

import Foundation
import SmartSimulationFramework

class SimulationInputRelationViewModel {
    
    let name: String
    let formula: String
    let delay: Int
    
    init(simulationRelation: SimulationRelation) {
        self.name = simulationRelation.simulation.name
        self.formula = simulationRelation.formula
        self.delay = simulationRelation.delay
    }
}

extension SimulationInputRelationViewModel: RelationProviderProtocol {
    
    func getName() -> String {
        return self.name
    }
    
    func getFormula() -> String {
        return self.formula
    }
}

extension SmartSimulationFramework.Category {
    
    var image: UIImage? {
        switch self {
        case .core:
            return UIImage()
        case .economy:
            return UIImage()
        case .welfare:
            return UIImage()
        case .foreign:
            return UIImage()
        case .lawOrder:
            return UIImage()
        case .publicServices:
            return UIImage()
        case .effects:
            return UIImage()
        case .groups:
            return UIImage()
        case .static:
            return UIImage()
        }
    }
}

class SimulationDetailViewModel {
    
    let image: UIImage?
    let name: String
    let summary: String
    let category: String
    let value: String
    var inputs: [SimulationInputRelationViewModel]
    var outputs: [SimulationInputRelationViewModel]
    
    init(simulation: Simulation?) {
        self.image = simulation?.image
        self.name = simulation?.name ?? "-"
        self.summary = simulation?.summary ?? "-"
        self.category = simulation?.category.text ?? "-"
        self.value = simulation?.valueText() ?? "-"
        
        self.inputs = []
        if let inputs = simulation?.inputs {
            for input in inputs {
                self.inputs.append(SimulationInputRelationViewModel(simulationRelation: input))
            }
        }
        
        self.outputs = []
        if let outputs = simulation?.outputs {
            for output in outputs {
                self.outputs.append(SimulationInputRelationViewModel(simulationRelation: output))
            }
        }
    }
    
    func getInputRelation(at index: Int) -> SimulationInputRelationViewModel? {
        return self.inputs[index]
    }
    
    func getOutputRelation(at index: Int) -> SimulationInputRelationViewModel? {
        return self.outputs[index]
    }
}

extension SimulationDetailViewModel: NameProviderProtocol {
    
    func getName() -> String {
        return self.name
    }
}

extension SimulationDetailViewModel: DescriptionProviderProtocol {
    
    func getDescription() -> String {
        return self.summary
    }
}

extension SimulationDetailViewModel: CategoryProviderProtocol {
    
    func getCategoryText() -> String {
        return self.category
    }
}

extension SimulationDetailViewModel: ValueProviderProtocol {
    
    func getValue() -> String {
        return self.value
    }
}
