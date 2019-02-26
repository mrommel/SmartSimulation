//
//  OnboardingViewModel.swift
//  Simulation
//
//  Created by Michael Rommel on 25.02.19.
//  Copyright © 2019 Michael Rommel. All rights reserved.
//

import UIKit
import Rswift

class OnboardingViewModel: ViewModelType {
    
    var delegate: ViewModelDelegate?
    
    var orderedViewControllers: [UIViewController] = []

    func bootstrap() {
        
        self.delegate?.willLoadData()
        
        let onboardingViewModel1 = OnboardingDetailViewModel(image: R.image.onboarding_welcome(), title: "Welcome", summary: "Screen 1", pageControlData: PageControlData(currentPage: 0, numberOfPages: 3), analyticsNavigationType: .navigateIntroWelcomeToSimulation)
        let onboardingViewModel2 = OnboardingDetailViewModel(image: R.image.onboarding_simulation(), title: "Simulations", summary: "Screen 2", pageControlData: PageControlData(currentPage: 1, numberOfPages: 3), analyticsNavigationType: .navigateIntroSimulationToLetsgo)
        let onboardingViewModel3 = OnboardingDetailViewModel(image: R.image.onboarding_letsgo(), title: "Let's go", summary: "Screen 3", pageControlData: PageControlData(currentPage: 2, numberOfPages: 3), analyticsNavigationType: .navigateIntroLetsgoToDashboard)
        
        self.orderedViewControllers = []
        
        self.orderedViewControllers.append(self.getViewController(with: onboardingViewModel1))
        self.orderedViewControllers.append(self.getViewController(with: onboardingViewModel2))
        self.orderedViewControllers.append(self.getViewController(with: onboardingViewModel3))
        
        self.delegate?.didLoadData()
    }
    
    func orderedViewControllerCount() -> Int {
        
        return self.orderedViewControllers.count
    }
    
    fileprivate func getViewController(with viewModel: OnboardingDetailViewModel) -> OnboardingDetailViewController {
        
        if let onboardingViewController = R.storyboard.main.onboardingDetailViewController() {
            onboardingViewController.viewModel = viewModel
            return onboardingViewController
        }
        
        fatalError("cant create onboarding viewcontroller")
    }
}
