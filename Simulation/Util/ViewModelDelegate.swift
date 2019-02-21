//
//  ViewModelDelegate.swift
//  simulation
//
//  Created by Michael Rommel on 08.02.19.
//  Copyright © 2019 Michael Rommel. All rights reserved.
//

import Foundation

protocol ViewModelDelegate: class {
    func willLoadData()
    func didLoadData()
    
    func performSegue(named segue: String)
    func showAlertText(title: String, text: String)
}

extension ViewModelDelegate {
    
    // make some methods optional
    func performSegue(named segue: String) { }
    func showAlertText(title: String, text: String) { }
}
