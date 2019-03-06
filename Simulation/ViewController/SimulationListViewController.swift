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
        } else if let destinationViewController = segue.destination as? SituationDetailViewController {
            destinationViewController.situationDetailViewModel = self.viewModel?.selectedSituationDetailViewModel
        } else if let destinationViewController = segue.destination as? PolicyDetailViewController {
            destinationViewController.policyDetailViewModel = self.viewModel?.selectedPolicyDetailViewModel
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
        return self.viewModel?.sectionCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.viewModel?.sectionTitle(for: section)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.simulations(in: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SimulationListViewController.reuseableIdentifier, for: indexPath)
        let simulation = self.viewModel?.detail(at: indexPath)
        cell.imageView?.image = simulation?.image
        cell.textLabel?.text = simulation?.name
        cell.detailTextLabel?.text = simulation?.value
        cell.tintColor = App.Color.tableViewCellAccessoryColor
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        self.viewModel?.selectDetail(at: indexPath)
    }
}
