//
//  GroupDetailViewModel.swift
//  Simulation
//
//  Created by Michael Rommel on 25.02.19.
//  Copyright © 2019 Michael Rommel. All rights reserved.
//

import UIKit
import SmartSimulationFramework

class GroupDetailViewModel {
    
    let image: UIImage?
    let name: String
    let summary: String
    
    init(group: Group) {
        self.image = group.image
        self.name = group.name
        self.summary = "\(group.frequency.valueText()) freq, \(group.mood.valueText()) mood"
    }
}
