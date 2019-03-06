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
        static var navigationBarBackgroundColor: UIColor { return UIColor(red: 128, green: 156, blue: 19) } // #809c13
        static var navigationBarTextColor: UIColor { return .white }
        
        static var tabBarItemNormalColor: UIColor { return .darkGray }
        static var tabBarItemSelectedColor: UIColor { return .black }
        
        static var viewBackgroundColor: UIColor { return .white }
        
        static var tableViewCellTextEnabledColor: UIColor { return .black }
        static var tableViewCellTextDisabledColor: UIColor { return .darkGray }
        static var tableViewCellAccessoryColor: UIColor { return UIColor(red: 128, green: 156, blue: 19) } // #809c13
        
        static var refreshControlColor: UIColor { return UIColor(red: 128, green: 156, blue: 19) } // #809c13
        
        static var alertControllerTextColor: UIColor { return .black }
        static var alertControllerTintColor: UIColor { return UIColor(red: 128, green: 156, blue: 19) } // #809c13
    }
    
    struct Font {
        static var alertTitleFont: UIFont { return UIFont(name: "Avenir-Roman", size: 20.0)! }
        static var alertSubtitleFont: UIFont { return UIFont(name: "Avenir-Roman", size: 14.0)! }
        static var alertTextFont: UIFont { return UIFont(name: "Avenir-Roman", size: 12.0)! }
    }
    
    init() {
        
    }
    
    func setup() {

        // UITabBar
        let attributesNormal = [ NSAttributedString.Key.foregroundColor: App.Color.tabBarItemNormalColor ]
        UITabBarItem.appearance().setTitleTextAttributes(attributesNormal, for: .normal)
        
        let attributesSelected = [ NSAttributedString.Key.foregroundColor: App.Color.tabBarItemSelectedColor ]
        UITabBarItem.appearance().setTitleTextAttributes(attributesSelected, for: .selected)
        
        // UINavigationBar
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().barTintColor = App.Color.navigationBarBackgroundColor
        UINavigationBar.appearance().tintColor = App.Color.navigationBarTextColor
    }
}
