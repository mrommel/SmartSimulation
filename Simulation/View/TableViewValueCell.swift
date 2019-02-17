//
//  TableViewValueCell.swift
//  Simulation
//
//  Created by Michael Rommel on 17.02.19.
//  Copyright © 2019 Michael Rommel. All rights reserved.
//

import UIKit

protocol ValueProviderProtocol {
    
    func getValue() -> String
}

class TableViewValueCell: UITableViewCell, DequeuableProtocol {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    func setup(with provider: ValueProviderProtocol?) {
        self.titleLabel?.text = "Value"
        self.valueLabel?.text = provider?.getValue()
    }
}
