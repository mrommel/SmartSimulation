//
//  SimulationDetailViewController.swift
//  Simulation
//
//  Created by Michael Rommel on 08.02.19.
//  Copyright © 2019 Michael Rommel. All rights reserved.
//

import UIKit

class SimulationDetailViewController: UIViewController {
    
    var simulationItemModel: SimulationItemModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.title = self.simulationItemModel?.name
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
