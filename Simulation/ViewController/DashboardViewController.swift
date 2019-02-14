//
//  DashboardViewController.swift
//  simulation
//
//  Created by Michael Rommel on 07.02.19.
//  Copyright © 2019 Michael Rommel. All rights reserved.
//

import UIKit
import Rswift

class DashboardViewController: UIViewController {

    @IBOutlet weak var turnButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        self.title = R.string.localizable.dashboardViewControllerTitle()
        self.view.backgroundColor = .white
    }
    
    @IBAction func turnAction(sender: UIView?) {
        print("turn")
        GlobalSimulationManager.shared.iterate()
    }
}



