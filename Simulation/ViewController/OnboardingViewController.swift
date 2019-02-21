//
//  OnboardingViewController.swift
//  Simulation
//
//  Created by Michael Rommel on 21.02.19.
//  Copyright © 2019 Michael Rommel. All rights reserved.
//

import UIKit

class OnboardingViewController: UIPageViewController {
    
    fileprivate lazy var orderedViewController: [UIViewController] = {
        return [self.getViewController(withIdentifier: "Onboarding1"),
                self.getViewController(withIdentifier: "Onboarding2"),
                self.getViewController(withIdentifier: "Onboarding3")]
    }()
    
    fileprivate func getViewController(withIdentifier identifier: String) -> UIViewController
    {
        return (storyboard?.instantiateViewController(withIdentifier: identifier))!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
        self.delegate = self
        
        if let firstViewController = orderedViewController.first {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
    }
}

extension OnboardingViewController: UIPageViewControllerDataSource {
    
    func presentationCount(for: UIPageViewController) -> Int {
        return self.orderedViewController.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = self.orderedViewController.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        guard nextIndex < self.orderedViewController.count else {
            self.performSegue(withIdentifier: "showDashboard", sender: self)
            return nil
        }
        guard self.orderedViewController.count > nextIndex else { return nil }
        return self.orderedViewController[nextIndex]
    }
}

extension OnboardingViewController: UIPageViewControllerDelegate {
    
}
