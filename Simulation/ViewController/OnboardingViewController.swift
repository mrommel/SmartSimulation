//
//  OnboardingViewController.swift
//  Simulation
//
//  Created by Michael Rommel on 21.02.19.
//  Copyright © 2019 Michael Rommel. All rights reserved.
//

import UIKit
import Rswift

class OnboardingViewController: UIPageViewController {
        
    var viewModel: OnboardingViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel = OnboardingViewModel()
        self.viewModel?.delegate = self
        self.viewModel?.bootstrap()
        
        self.dataSource = self
        self.delegate = self
    }
}

extension OnboardingViewController:ViewModelDelegate {
    
    func willLoadData() {
        
    }
    
    func didLoadData() {
        if let firstViewController = self.viewModel?.orderedViewControllers.first {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
    }
}

extension OnboardingViewController: UIPageViewControllerDataSource {
    
    func presentationCount(for: UIPageViewController) -> Int {
        return self.viewModel?.orderedViewControllerCount() ?? 0
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        return nil // don't go back
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = self.viewModel?.orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllerCount = self.viewModel?.orderedViewControllerCount() ?? 0
        
        guard nextIndex < orderedViewControllerCount else {
            if let lastViewController =  self.viewModel?.orderedViewControllers.last as? OnboardingDetailViewController {
                lastViewController.viewModel?.trackNavigation()
            }
            self.performSegue(withIdentifier: R.segue.onboardingViewController.showDashboard.identifier, sender: self)
            return nil
        }
        
        guard orderedViewControllerCount > nextIndex else {
            return nil
        }
        
        return self.viewModel?.orderedViewControllers[nextIndex]
    }
}

extension OnboardingViewController: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        if let lastViewController = previousViewControllers.last as? OnboardingDetailViewController {
            lastViewController.viewModel?.trackNavigation()
        }
    }
}
