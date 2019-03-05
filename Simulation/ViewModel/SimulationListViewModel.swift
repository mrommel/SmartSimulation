//
//  SimulationListViewModel.swift
//  simulation
//
//  Created by Michael Rommel on 08.02.19.
//  Copyright © 2019 Michael Rommel. All rights reserved.
//

import Foundation
import SmartSimulationFramework

class SimulationListViewModel: ViewModelType {
    
    static let simulationDetailSegue = R.segue.simulationListViewController.showSimulation
    static let situationDetailSegue = R.segue.simulationListViewController.showSituation
    static let policyDetailSegue = R.segue.simulationListViewController.showPolicy

    internal var delegate: ViewModelDelegate?
    var detailViewModels: [DetailViewModel] = []
    
    internal var selectedSimulationDetailViewModel: DetailViewModel?
    internal var selectedSituationDetailViewModel: DetailViewModel?
    internal var selectedPolicyDetailViewModel: DetailViewModel?
    
    func bootstrap() {
        self.loadData()
    }
    
    func loadData() {
        delegate?.willLoadData()
        
        Delay.delayed(by: 0.1) {
            
            self.detailViewModels = []
            
            if let simulations = GlobalSimulationManager.shared.simulations() {
                for simulation in simulations {
                    self.detailViewModels.append(SimulationDetailViewModel(simulation: simulation))
                }
            }
            
            if let situations = GlobalSimulationManager.shared.situations() {
                for situation in situations {
                    self.detailViewModels.append(SituationDetailViewModel(situation: situation))
                }
            }
            
            if let policies = GlobalSimulationManager.shared.policies() {
                for policy in policies {
                    self.detailViewModels.append(PolicyDetailViewModel(policy: policy))
                }
            }
            
            DispatchQueue.main.async {
                self.delegate?.didLoadData()
            }
        }
    }
    
    /*func addSimulation() {
        // self.delegate?.performSegue(named: SimulationListViewModel.simulationDetailSegue.identifier)
    }*/
    
    func sectionCount() -> Int {
        
        return Category.allCases.count
    }
    
    func sectionTitle(for section: Int) -> String {
        
        let sectionCategory = Category.allCases[section]
        return sectionCategory.text
    }
    
    func simulations(in section: Int) -> Int {
        
        let sectionCategory = Category.allCases[section]
        return self.detailViewModels.count { $0.category == sectionCategory.text }
    }
    
    func detail(at indexPath: IndexPath) -> DetailViewModel? {
        let sectionCategory = Category.allCases[indexPath.section]
        let sectionDetails = self.detailViewModels.filter { $0.category == sectionCategory.text }
        
        return sectionDetails[indexPath.row]
    }
    
    func selectDetail(at indexPath: IndexPath) {
        
        print("selectDetail \(indexPath)")
        
        let detail = self.detail(at: indexPath)
        let type: DetailViewModelType = detail?.type ?? .simulation
        
        switch type {
        
        case .simulation:
            AppAnalytics.logNavigation(navigation: .navigateSimulationsToSimulation)
            self.selectedSimulationDetailViewModel = detail
            self.delegate?.performSegue(named: SimulationListViewModel.simulationDetailSegue.identifier)
        case .situation:
            AppAnalytics.logNavigation(navigation: .navigateSimulationsToSituation)
            self.selectedSituationDetailViewModel = detail
            self.delegate?.performSegue(named: SimulationListViewModel.situationDetailSegue.identifier)
        case .policy:
            AppAnalytics.logNavigation(navigation: .navigateSimulationsToPolicy)
            self.selectedPolicyDetailViewModel = detail
            self.delegate?.performSegue(named: SimulationListViewModel.policyDetailSegue.identifier)
        }
        
    }
}
