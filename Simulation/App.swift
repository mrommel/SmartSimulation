//
//  App.swift
//  Simulation
//
//  Created by Michael Rommel on 15.02.19.
//  Copyright © 2019 Michael Rommel. All rights reserved.
//

import UIKit

class App {
    
    struct Color {
        static var navigationBarBackgroundColor: UIColor { return UIColor(hex: "#809C13") }
        static var navigationBarTextColor: UIColor { return .white }
        
        static var tabBarItemNormal: UIColor { return .darkGray }
        static var tabBarItemSelected: UIColor { return .black }
        
        static var viewBackgroundColor: UIColor { return .white }
        
        static var tableViewCellTextEnabled: UIColor { return .black }
        static var tableViewCellTextDisabled: UIColor { return .darkGray }
        
        static var refreshControlColor: UIColor { return UIColor(hex: "#809C13") }
    }
    
    init() {
        
    }
    
    func setup() {

        // UITabBar
        let attributesNormal = [ NSAttributedString.Key.foregroundColor: App.Color.tabBarItemNormal ]
        UITabBarItem.appearance().setTitleTextAttributes(attributesNormal, for: .normal)
        
        let attributesSelected = [ NSAttributedString.Key.foregroundColor: App.Color.tabBarItemSelected ]
        UITabBarItem.appearance().setTitleTextAttributes(attributesSelected, for: .selected)
        
        // UINavigationBar
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().barTintColor = App.Color.navigationBarBackgroundColor
        UINavigationBar.appearance().tintColor = App.Color.navigationBarTextColor
    }
}
