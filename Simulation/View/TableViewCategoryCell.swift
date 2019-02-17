//
//  TableViewCategoryCell.swift
//  Simulation
//
//  Created by Michael Rommel on 17.02.19.
//  Copyright © 2019 Michael Rommel. All rights reserved.
//

import UIKit

protocol CategoryProviderProtocol {
    
    func getCategoryText() -> String
}

class TableViewCategoryCell: UITableViewCell, DequeuableProtocol {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    func setup(with provider: CategoryProviderProtocol?) {
        self.titleLabel?.text = "Category"
        self.valueLabel?.text = provider?.getCategoryText()
    }
}
