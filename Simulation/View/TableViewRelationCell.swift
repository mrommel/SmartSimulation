//
//  TableViewRelationCell.swift
//  Simulation
//
//  Created by Michael Rommel on 18.02.19.
//  Copyright © 2019 Michael Rommel. All rights reserved.
//

import UIKit

protocol RelationProviderProtocol {
    
    func getName() -> String
    func getFormula() -> String
}

class TableViewRelationCell: UITableViewCell, DequeuableProtocol {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    func setup(with provider: RelationProviderProtocol?) {
        self.titleLabel?.text = provider?.getName()
        self.valueLabel?.text = provider?.getFormula()
    }
}
