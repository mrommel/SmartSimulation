//
//  SimulationListViewController.swift
//  simulation
//
//  Created by Michael Rommel on 07.02.19.
//  Copyright © 2019 Michael Rommel. All rights reserved.
//

import UIKit
import Rswift

class SimulationListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    private static let reuseableIdentifier = "SimulationCell"
    
    var viewModel: SimulationListViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // initialize the view model
        self.viewModel = SimulationListViewModel()
        self.viewModel?.delegate = self
        self.viewModel?.bootstrap()
        
        // Do any additional setup after loading the view.
        self.title = "Simulation"
        self.view.backgroundColor = .white
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView()
        
        let addSimulationButton = UIBarButtonItem(image: R.image.plus(), style: .plain, target: self, action: #selector(SimulationListViewController.addSimulation))
        addSimulationButton.tintColor = .white
        self.navigationItem.rightBarButtonItem = addSimulationButton
    }
    
    @objc func addSimulation() {
        self.viewModel?.addSimulation()
    }
}

// notifications from the view model
extension SimulationListViewController: ViewModelDelegate {
    
    func willLoadData() {
        activityIndicator?.startAnimating()
    }
    
    func didLoadData() {
        // reloads tableView data from model.taskNames
        tableView.reloadData()
        activityIndicator?.stopAnimating()
    }
    
    func performSegue(named segue: String) {
        self.performSegue(withIdentifier: segue, sender: self)
    }
}

extension SimulationListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.simulationCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Simulations"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SimulationListViewController.reuseableIdentifier, for: indexPath)
        let simulation = self.viewModel?.simulation(at: indexPath.row)
        cell.textLabel?.text = simulation?.name
        return cell
    }
}
