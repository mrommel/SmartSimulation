//
//  AppAnalytics.swift
//  Simulation
//
//  Created by Michael Rommel on 19.02.19.
//  Copyright © 2019 Michael Rommel. All rights reserved.
//

import Foundation
import Firebase
import SwiftLog

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
    case navigateNavBarToGroups
    case navigateNavBarToSettings
    
    case navigateSimulationsToSimulation
    
    var trackingKey: String {
        switch self {
        case .navigateNavBarToDashboard:
            return "navigate_nav_dashboard"
        case .navigateNavBarToSimulations:
            return "navigate_nav_simulations"
        case .navigateNavBarToGroups:
            return "navigate_nav_groups"
        case .navigateNavBarToSettings:
            return "navigate_nav_settings"
            
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
    }
    
    static func logEvent(event: AnalyticsEventType, parameters: [String: Any]? = nil) {
        
        Analytics.logEvent(event.trackingKey, parameters: parameters)
        logw("Analytics event navigation: \(event.trackingKey)")
    }
    
    static func logNavigation(navigation: AnalyticsNavigationType) {
        Analytics.logEvent(navigation.trackingKey, parameters: nil)
        logw("Analytics log navigation: \(navigation.trackingKey)")
    }
}
