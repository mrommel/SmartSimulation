//
//  Storyboardable.swift
//  Simulation
//
//  Created by Michael Rommel on 21.02.19.
//  Copyright © 2019 Michael Rommel. All rights reserved.
//

import UIKit

protocol Storyboardable: class {
    //static var viewControllerName: String { get }
}

extension Storyboardable where Self: UIViewController {
   
    /*static func storyboardViewController<T: UIViewController>() -> T {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let identifier = String(describing: T.self)
        
        guard let viewcontroller = storyboard.instantiateViewController(withIdentifier: identifier) as? T else {
            fatalError("Could not instantiate viewcontroller with name: \(identifier)")
        }
        
        return viewcontroller
    }*/
    
    static func storyboardViewController<T: UIViewController>(withIdentifier identifier: String) -> T {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let viewcontroller = storyboard.instantiateViewController(withIdentifier: identifier) as? T else {
            fatalError("Could not instantiate viewcontroller with name: \(identifier)")
        }
        
        return viewcontroller
    }
}

extension UIViewController: Storyboardable { }
