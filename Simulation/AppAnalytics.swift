//
//  AppAnalytics.swift
//  Simulation
//
//  Created by Michael Rommel on 19.02.19.
//  Copyright © 2019 Michael Rommel. All rights reserved.
//

import Foundation
import Firebase

enum AnalyticsEventType {
    
    case pressTurn
    case refreshSimulations
    case refreshDashboard
    
    var trackingKey: String {
        switch self {
        case .pressTurn:
            return "press_turn"
        case .refreshSimulations:
            return "refresh_simulations"
        case .refreshDashboard:
            return "refresh_dashboard"
        }
    }
}

enum AnalyticsNavigationType {
    
    case navigateIntroWelcomeToSimulation
    case navigateIntroSimulationToLetsgo
    case navigateIntroLetsgoToDashboard
    
    case navigateNavBarToDashboard
    case navigateNavBarToSimulations
    
    case navigateSimulationsToSimulation
    
    var trackingKey: String {
        switch self {
        case .navigateNavBarToDashboard:
            return "navigate_nav_dashboard"
        case .navigateNavBarToSimulations:
            return "navigate_nav_simulations"
        case .navigateSimulationsToSimulation:
            return "navigate_simulations_simulation"
            
        case .navigateIntroWelcomeToSimulation:
            return "navigate_intro_welcome_simulations"
        case .navigateIntroSimulationToLetsgo:
            return "navigate_intro_simulations_letsgo"
        case .navigateIntroLetsgoToDashboard:
            return "navigate_intro_letsgo_dashboard"
        }
    }
}

class AppAnalytics {
    
    static func setup() {
        // initializes firebase (not only analytics)
        FirebaseApp.configure()
        
        // map screen names
        /*Analytics.setScreenName("dashboard", screenClass: String(describing: DashboardViewController.self))
        Analytics.setScreenName("dashboard2", screenClass: "DashboardViewController") // cross check
        
        Analytics.setScreenName("simulations", screenClass: String(describing: SimulationListViewController.self))
        Analytics.setScreenName("simulation", screenClass: String(describing: SimulationDetailViewController.self))*/
    }
    
    static func logEvent(event: AnalyticsEventType, parameters: [String: Any]? = nil) {
        
        Analytics.setUserProperty("Fritz!Box 7590", forName: "router") // just a test
        Analytics.logEvent(event.trackingKey, parameters: parameters)
    }
    
    static func logNavigation(navigation: AnalyticsNavigationType) {
        Analytics.logEvent(navigation.trackingKey, parameters: nil)
    }
}
