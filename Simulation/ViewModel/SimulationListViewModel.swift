//
//  SimulationListViewModel.swift
//  simulation
//
//  Created by Michael Rommel on 08.02.19.
//  Copyright © 2019 Michael Rommel. All rights reserved.
//

import Foundation
import Rswift
import SmartSimulationFramework

class SimulationListRouter {
    
    func showSimulation(with viewModel: DetailViewModel, from context: UIViewController) {
        
        if let simulationDetailViewController = R.storyboard.main.simulationDetailViewController() {
            simulationDetailViewController.simulationDetailViewModel = viewModel
            context.navigationController?.pushViewController(simulationDetailViewController, animated: true)
        }
    }
    
    func showSituation(with viewModel: DetailViewModel, from context: UIViewController) {
        
        if let situationDetailViewController = R.storyboard.main.situationDetailViewController() {
            situationDetailViewController.situationDetailViewModel = viewModel
            context.navigationController?.pushViewController(situationDetailViewController, animated: true)
        }
    }
    
    func showPolicy(with viewModel: DetailViewModel, from context: UIViewController) {
        
        if let policyDetailViewController = R.storyboard.main.policyDetailViewController() {
            policyDetailViewController.policyDetailViewModel = viewModel
            context.navigationController?.pushViewController(policyDetailViewController, animated: true)
        }
    }
    
    func showPolicySelection(title: String, data: [PolicySelection]?, selectedIndex: Int?, onSelect: @escaping (PolicySelection) -> (), from context: UIViewController) {

        let viewController = PolicySelectionController(
            title: title,
            data: data,
            selectedIndex: selectedIndex,
            onSelect: onSelect)
        
        context.navigationController?.pushViewController(viewController, animated: true)
    }
}

class SimulationListViewModel: ViewModelType {
    
    static let simulationDetailSegue = R.segue.simulationListViewController.showSimulation
    static let situationDetailSegue = R.segue.simulationListViewController.showSituation
    static let policyDetailSegue = R.segue.simulationListViewController.showPolicy

    internal var delegate: ViewModelDelegate?
    var detailViewModels: [DetailViewModel] = []
    var router: SimulationListRouter?
    
    internal var selectedSimulationDetailViewModel: DetailViewModel?
    internal var selectedSituationDetailViewModel: DetailViewModel?
    internal var selectedPolicyDetailViewModel: DetailViewModel?
    
    func bootstrap() {
        self.loadData()
    }
    
    func loadData() {
        delegate?.willLoadData()
        
        self.router = SimulationListRouter()
        
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
    
    func sectionCount() -> Int {
        
        return Category.listItems.count
    }
    
    func sectionTitle(for section: Int) -> String {
        
        let sectionCategory = Category.listItems[section]
        return sectionCategory.text
    }
    
    func simulations(in section: Int) -> Int {
        
        let sectionCategory = Category.listItems[section]
        return self.detailViewModels.count { $0.category == sectionCategory.text }
    }
    
    func detail(at indexPath: IndexPath) -> DetailViewModel? {
        let sectionCategory = Category.listItems[indexPath.section]
        let sectionDetails = self.detailViewModels.filter { $0.category == sectionCategory.text }
        
        return sectionDetails[indexPath.row]
    }
    
    func selectDetail(at indexPath: IndexPath, from context: UIViewController) {

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
