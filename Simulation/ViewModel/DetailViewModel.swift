//
//  SimulationDetailViewModel.swift
//  Simulation
//
//  Created by Michael Rommel on 17.02.19.
//  Copyright © 2019 Michael Rommel. All rights reserved.
//

import Foundation
import SmartSimulationFramework

enum DetailViewModelType {
    
    case simulation
    case situation
    case policy
}

struct RelationIdentifier {

    let identifier: String
    let formula: String
}

class DetailViewModel {
    
    let image: UIImage?
    let name: String
    let summary: String
    let category: String
    let value: String
    var formula: String = ""
    var inputIdentifiers: [RelationIdentifier] = []
    var outputIdentifiers: [RelationIdentifier] = []
    let type: DetailViewModelType
    var router: SimulationListRouter?
    
    internal var delegate: ViewModelDelegate?
    
    init(image: UIImage?, name: String, summary: String, category: String, value: String, type: DetailViewModelType) {
        
        self.image = image
        self.name = name
        self.summary = summary
        self.category = category
        self.value = value
        self.type = type
        
        self.router = SimulationListRouter()
    }
    
    func getInputRelation(at index: Int) -> DetailViewModel? {
        
        let relationIdentifier = self.inputIdentifiers[index]
        let simulation = GlobalSimulationManager.shared.simulation(by: relationIdentifier.identifier)
        
        return SimulationDetailViewModel(simulation: simulation)
    }
    
    func getOutputRelation(at index: Int) -> DetailViewModel? {
        
        let relationIdentifier = self.outputIdentifiers[index]
        let simulation = GlobalSimulationManager.shared.simulation(by: relationIdentifier.identifier)
        
        return SimulationDetailViewModel(simulation: simulation)
    }
    
    func detail(at indexPath: IndexPath) -> DetailViewModel? {
        
        if indexPath.section == 1 {
            return self.getInputRelation(at: indexPath.row)
        } else if indexPath.section == 2 {
            return self.getOutputRelation(at: indexPath.row)
        }
        
        return nil
    }
    
    func selectDetail(at indexPath: IndexPath, from context: UIViewController) {
        
        guard indexPath.section == 1 || indexPath.section == 2 else {
            return
        }
        
        guard let detail = self.detail(at: indexPath) else {
            fatalError("Can't get content")
        }
        
        let type: DetailViewModelType = detail.type
        
        switch type {
            
        case .simulation:
            AppAnalytics.logNavigation(navigation: .navigateSimulationsToSimulation)
            self.router?.showSimulation(with: detail, from: context)
        case .situation:
            AppAnalytics.logNavigation(navigation: .navigateSimulationsToSituation)
            self.router?.showSituation(with: detail, from: context)
        case .policy:
            AppAnalytics.logNavigation(navigation: .navigateSimulationsToPolicy)
            self.router?.showPolicy(with: detail, from: context)
        }
    }
}

extension DetailViewModel: RelationProviderProtocol {
    
    func getName() -> String {
        return self.name
    }
    
    func getFormula() -> String {
        return self.formula
    }
}

extension DetailViewModel: NameProviderProtocol {
    
    /*func getName() -> String {
        return self.name
    }*/
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
