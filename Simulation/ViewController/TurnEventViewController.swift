//
//  TurnEventViewController.swift
//  Simulation
//
//  Created by Michael Rommel on 20.02.19.
//  Copyright © 2019 Michael Rommel. All rights reserved.
//

import UIKit

// https://github.com/apraka16/swipeableOnboardingUIPageView/blob/master/testPageView/OnboardingViewController.swift

class TurnEventViewController: UIPageViewController, UIPageViewControllerDelegate {
    
    var viewModel: TurnEventViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // initialize the view model
        self.viewModel = TurnEventViewModel()
        self.viewModel?.delegate = self
        self.viewModel?.bootstrap()
    }
}

extension TurnEventViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return nil
    }
}

extension TurnEventViewController: ViewModelDelegate {
    
    func willLoadData() {
        
    }
    
    func didLoadData() {
        
    }
}
