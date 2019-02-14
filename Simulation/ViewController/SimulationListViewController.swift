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
    private static let reuseableIdentifier = "SimulationCell"
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(SimulationListViewController.handleRefresh(_:)), for: .valueChanged)
        refreshControl.tintColor = UIColor.red
        
        var attributes: [NSAttributedString.Key : Any] = [:]
        attributes[.foregroundColor] = UIColor.red
        refreshControl.attributedTitle = NSAttributedString(string: R.string.localizable.simulationListViewControllerRefreshControlText(), attributes: attributes)
        
        return refreshControl
    }()
    
    var viewModel: SimulationListViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // initialize the view model
        self.viewModel = SimulationListViewModel()
        self.viewModel?.delegate = self
        self.viewModel?.bootstrap()
        
        // Do any additional setup after loading the view.
        self.title = R.string.localizable.simulationListViewControllerTitle()
        self.view.backgroundColor = .white
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView()
        self.tableView.addSubview(self.refreshControl)
        
        let addSimulationButton = UIBarButtonItem(image: R.image.plus(), style: .plain, target: self, action: #selector(SimulationListViewController.addSimulation))
        addSimulationButton.tintColor = .white
        self.navigationItem.rightBarButtonItem = addSimulationButton
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        self.viewModel?.loadData()
    }
    
    @objc func addSimulation() {
        self.viewModel?.addSimulation()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationViewController = segue.destination as? SimulationDetailViewController {
            destinationViewController.simulationItemModel = self.viewModel?.selectedSimulationItemModel
        }
    }
}

// notifications from the view model
extension SimulationListViewController: ViewModelDelegate {
    
    func willLoadData() {
        
    }
    
    func didLoadData() {
        self.tableView.reloadData()
        self.refreshControl.endRefreshing()
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
        return R.string.localizable.simulationListViewControllerTitle()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SimulationListViewController.reuseableIdentifier, for: indexPath)
        let simulation = self.viewModel?.simulation(at: indexPath.row)
        cell.textLabel?.text = simulation?.name
        cell.detailTextLabel?.text = simulation?.value
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewModel?.selectSimulation(at: indexPath.row)
    }
}
