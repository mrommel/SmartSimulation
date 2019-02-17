//
//  TableViewNameCell.swift
//  Simulation
//
//  Created by Michael Rommel on 16.02.19.
//  Copyright © 2019 Michael Rommel. All rights reserved.
//

import UIKit

protocol NameProviderProtocol {
    
    func getName() -> String
}

class TableViewNameCell: UITableViewCell, DequeuableProtocol {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    func setup(with provider: NameProviderProtocol?) {
        self.titleLabel?.text = "Name"
        self.valueLabel?.text = provider?.getName()
    }
}
