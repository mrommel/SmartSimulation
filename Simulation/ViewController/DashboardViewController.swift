//
//  DashboardViewController.swift
//  simulation
//
//  Created by Michael Rommel on 07.02.19.
//  Copyright © 2019 Michael Rommel. All rights reserved.
//

import UIKit
import Rswift
import Firebase

class DashboardViewController: UIViewController {

    private static let reuseableIdentifier = "DashboardCell"
    
    @IBOutlet weak var tableView: UITableView!
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(SimulationListViewController.handleRefresh(_:)), for: .valueChanged)
        refreshControl.tintColor = App.Color.refreshControlColor
        
        var attributes: [NSAttributedString.Key : Any] = [:]
        attributes[.foregroundColor] = App.Color.refreshControlColor
        refreshControl.attributedTitle = NSAttributedString(string: R.string.localizable.simulationListViewControllerRefreshControlText(), attributes: attributes)
        
        return refreshControl
    }()
    
    var viewModel: DashboardViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // initialize the view model
        self.viewModel = DashboardViewModel()
        self.viewModel?.delegate = self
        self.viewModel?.bootstrap()
        
        // Do any additional setup after loading the view, typically from a nib.
        self.title = R.string.localizable.dashboardViewControllerTitle()
        self.view.backgroundColor = App.Color.viewBackgroundColor
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView()
        self.tableView.addSubview(self.refreshControl)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: R.image.turn(), style: .plain, target: self, action: #selector(turnAction))
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func turnAction(sender: UIView?) {
        print("turn pressed")
        GlobalSimulationManager.shared.iterate()
        AppAnalytics.logEvent(event: .pressTurn)
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        self.viewModel?.loadData()
        AppAnalytics.logEvent(event: .refreshDashboard)
    }
}

// notifications from the view model
extension DashboardViewController: ViewModelDelegate {
    
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

extension DashboardViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.eventCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DashboardViewController.reuseableIdentifier, for: indexPath)
        
        let event = self.viewModel?.event(at: indexPath.row)
        
        cell.imageView?.image = event?.image
        cell.textLabel?.text = event?.title
        cell.detailTextLabel?.text = event?.summary
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
}
