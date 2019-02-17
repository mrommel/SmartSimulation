//
//  TableViewDescriptionCell.swift
//  Simulation
//
//  Created by Michael Rommel on 17.02.19.
//  Copyright © 2019 Michael Rommel. All rights reserved.
//

import UIKit

protocol DescriptionProviderProtocol {
    
    func getDescription() -> String
}

class TableViewDescriptionCell: UITableViewCell, DequeuableProtocol {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    func setup(with provider: DescriptionProviderProtocol?) {
        self.titleLabel?.text = "Description"
        self.valueLabel?.text = provider?.getDescription()
        self.valueLabel?.sizeToFit()
    }
}
