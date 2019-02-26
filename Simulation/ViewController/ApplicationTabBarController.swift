//
//  ApplicationTabBarController.swift
//  Simulation
//
//  Created by Michael Rommel on 20.02.19.
//  Copyright © 2019 Michael Rommel. All rights reserved.
//

import UIKit

class ApplicationTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
    }
}

extension ApplicationTabBarController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if viewController.children.first is DashboardViewController {
            AppAnalytics.logNavigation(navigation: .navigateNavBarToDashboard)
        } else if viewController.children.first is SimulationListViewController {
            AppAnalytics.logNavigation(navigation: .navigateNavBarToSimulations)
        } else if viewController.children.first is GroupListViewController {
            AppAnalytics.logNavigation(navigation: .navigateNavBarToGroups)
        } else if viewController.children.first is SettingsViewController {
            AppAnalytics.logNavigation(navigation: .navigateNavBarToSettings)
        }
    }
}
