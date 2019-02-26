//
//  GroupListViewController.swift
//  Simulation
//
//  Created by Michael Rommel on 25.02.19.
//  Copyright © 2019 Michael Rommel. All rights reserved.
//

import UIKit

class GroupListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private static let reuseableIdentifier = "GroupCell"
    
    var viewModel: GroupListViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel = GroupListViewModel()
        self.viewModel?.delegate = self
        self.viewModel?.bootstrap()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.tableFooterView = UIView()
    }
}

extension GroupListViewController: ViewModelDelegate {
    
    func willLoadData() {
        
    }
    
    func didLoadData() {
        
        self.tableView.reloadData()
    }
}

extension GroupListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.groupCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: GroupListViewController.reuseableIdentifier, for: indexPath)
        
        let group = self.viewModel?.group(at: indexPath)
        cell.imageView?.image = group?.image
        cell.textLabel?.text = group?.name
        cell.detailTextLabel?.text = group?.summary
        
        return cell
    }
}

extension GroupListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        //self.viewModel?.selectSimulation(at: indexPath.row)
        //AppAnalytics.logNavigation(navigation: .navigateSimulationsToSimulation)
    }
}
