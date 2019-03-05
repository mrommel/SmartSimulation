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
        case .religion:
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

enum DetailViewModelType {
    
    case simulation
    case situation
    case policy
}

class DetailViewModel {
    
    let image: UIImage?
    let name: String
    let summary: String
    let category: String
    let value: String
    var inputs: [SimulationInputRelationViewModel] = []
    var outputs: [SimulationInputRelationViewModel] = []
    let type: DetailViewModelType
    
    init(image: UIImage?, name: String, summary: String, category: String, value: String, type: DetailViewModelType) {
        
        self.image = image
        self.name = name
        self.summary = summary
        self.category = category
        self.value = value
        self.type = type
    }
    
    func getInputRelation(at index: Int) -> SimulationInputRelationViewModel? {
        return self.inputs[index]
    }
    
    func getOutputRelation(at index: Int) -> SimulationInputRelationViewModel? {
        return self.outputs[index]
    }
}

class SimulationDetailViewModel : DetailViewModel {
    
    init(simulation: Simulation?) {
        
        super.init(image: simulation?.image, name: simulation?.name ?? "-", summary: simulation?.summary ?? "-", category: simulation?.category.text ?? "-", value: simulation?.valueText() ?? "-", type: .simulation)

        if let inputs = simulation?.inputs {
            for input in inputs {
                self.inputs.append(SimulationInputRelationViewModel(simulationRelation: input))
            }
        }

        if let outputs = simulation?.outputs {
            for output in outputs {
                self.outputs.append(SimulationInputRelationViewModel(simulationRelation: output))
            }
        }
    }
}

class SituationDetailViewModel : DetailViewModel {
    
    init(situation: Situation?) {
        
        super.init(image: situation?.image, name: situation?.name ?? "-", summary: situation?.summary ?? "-", category: situation?.category.text ?? "-", value: situation?.valueText() ?? "-", type: .situation)

        if let inputs = situation?.inputs {
            for input in inputs {
                self.inputs.append(SimulationInputRelationViewModel(simulationRelation: input))
            }
        }
        
        if let outputs = situation?.outputs {
            for output in outputs {
                self.outputs.append(SimulationInputRelationViewModel(simulationRelation: output))
            }
        }
    }
}


class PolicyDetailViewModel : DetailViewModel {
    
    let policy: Policy?
    
    init(policy: Policy?) {
        
        self.policy = policy
        
        super.init(image: policy?.image, name: policy?.name ?? "-", summary: policy?.summary ?? "-", category: policy?.category.text ?? "-", value: policy?.valueText() ?? "-", type: .policy)
        
        if let inputs = policy?.inputs {
            for input in inputs {
                self.inputs.append(SimulationInputRelationViewModel(simulationRelation: input))
            }
        }
        
        if let outputs = policy?.outputs {
            for output in outputs {
                self.outputs.append(SimulationInputRelationViewModel(simulationRelation: output))
            }
        }
    }
}

extension DetailViewModel: NameProviderProtocol {
    
    func getName() -> String {
        return self.name
    }
}

extension DetailViewModel: DescriptionProviderProtocol {
    
    func getDescription() -> String {
        return self.summary
    }
}

extension DetailViewModel: CategoryProviderProtocol {
    
    func getCategoryText() -> String {
        return self.category
    }
}

extension DetailViewModel: ValueProviderProtocol {
    
    func getValue() -> String {
        return self.value
    }
}
