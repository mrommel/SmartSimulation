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
        refreshControl.tintColor = App.Color.refreshControlColor
        
        var attributes: [NSAttributedString.Key : Any] = [:]
        attributes[.foregroundColor] = App.Color.refreshControlColor
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
        self.view.backgroundColor = App.Color.viewBackgroundColor
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView()
        self.tableView.addSubview(self.refreshControl)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        self.viewModel?.loadData()
        AppAnalytics.logEvent(event: .refreshSimulations)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationViewController = segue.destination as? SimulationDetailViewController {
            destinationViewController.simulationDetailViewModel = self.viewModel?.selectedSimulationDetailViewModel
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
        cell.imageView?.image = simulation?.image
        cell.textLabel?.text = simulation?.name
        cell.detailTextLabel?.text = simulation?.value
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        self.viewModel?.selectSimulation(at: indexPath.row)
        AppAnalytics.logNavigation(navigation: .navigateSimulationsToSimulation)
    }
}
