//
//  SimulationDetailViewController.swift
//  Simulation
//
//  Created by Michael Rommel on 08.02.19.
//  Copyright © 2019 Michael Rommel. All rights reserved.
//

import UIKit

class SimulationDetailViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    /*@IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!*/
    
    var simulationItemModel: SimulationItemModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.title = self.simulationItemModel?.name
        self.view.backgroundColor = App.Color.viewBackgroundColor
        
        self.tableView.delegate = self
        self.tableView.dataSource = self

        self.tableView.register(TableViewNameCell.self)
        self.tableView.register(TableViewDescriptionCell.self)
        
        self.tableView.tableFooterView = UIView()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension SimulationDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 60
        case 1:
            return 140
        default:
            return 60
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let cell: TableViewNameCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.setup(with: self.simulationItemModel)
            return cell
        case 1:
            let cell: TableViewDescriptionCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.setup(with: self.simulationItemModel)
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
}
