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
import SmartSimulationFramework

class DashboardViewController: UIViewController {

    private static let reuseableIdentifier = "DashboardCell"

    @IBOutlet weak var tableView: UITableView!

    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(SimulationListViewController.handleRefresh(_:)), for: .valueChanged)
        refreshControl.tintColor = App.Color.refreshControlColor

        var attributes: [NSAttributedString.Key: Any] = [:]
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
        
        //
        GlobalSimulationManager.shared.delegate = self

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

extension DashboardViewController: GlobalSimulationInteractionDelegate {
    
    func showAlert(for event: Event?) {
        
        let alertController = UIAlertController(title: "", message: "", preferredStyle: .alert)

        let titleFont = [NSAttributedString.Key.font: App.Font.alertTitleFont]
        let messageFont = [NSAttributedString.Key.font: App.Font.alertTextFont]
        
        let titleAttrString = NSMutableAttributedString(string: event?.name ?? "", attributes: titleFont)
        let messageAttrString = NSMutableAttributedString(string: event?.summary ?? "", attributes: messageFont)
        
        alertController.setValue(titleAttrString, forKey: "attributedTitle")
        alertController.setValue(messageAttrString, forKey: "attributedMessage")
        
        let okAction = UIAlertAction(title: R.string.localizable.dashboardViewControllerButtonOkay(), style: .default) { (action) in
            GlobalSimulationManager.shared.select(of: event!)
        }
        alertController.addAction(okAction)
        
        alertController.view.tintColor = App.Color.alertControllerTintColor
        alertController.view.backgroundColor = App.Color.alertControllerBackgroundColor
        
        present(alertController, animated: true, completion: nil)
    }
    
    func showAlert(for dilemma: Dilemma?) {
        
        let alertController = UIAlertController(title: "", message: "", preferredStyle: .alert)
        
        let titleFont = [NSAttributedString.Key.font: App.Font.alertTitleFont]
        let subtitleFont = [NSAttributedString.Key.font: App.Font.alertSubtitleFont]
        let messageFont = [NSAttributedString.Key.font: App.Font.alertTextFont]
        
        let titleAttrString = NSMutableAttributedString(string: dilemma?.name ?? "", attributes: titleFont)
        let messageAttrString = NSMutableAttributedString(string: "\(dilemma?.summary ?? "")\n", attributes: messageFont)
        messageAttrString.append(NSMutableAttributedString(string: "\(dilemma?.firstOption.title ?? "")\n", attributes: subtitleFont))
        messageAttrString.append(NSMutableAttributedString(string: "\(dilemma?.firstOption.summary ?? "")\n", attributes: messageFont))
        messageAttrString.append(NSMutableAttributedString(string: "\(dilemma?.secondOption.title ?? "")\n", attributes: subtitleFont))
        messageAttrString.append(NSMutableAttributedString(string: "\(dilemma?.secondOption.summary ?? "")", attributes: messageFont))
        
        alertController.setValue(titleAttrString, forKey: "attributedTitle")
        alertController.setValue(messageAttrString, forKey: "attributedMessage")
        
        let firstOptionAction = UIAlertAction(title: dilemma?.firstOption.title, style: .default) { (action) in
            GlobalSimulationManager.shared.select(option: .option1, of: dilemma!)
        }
        alertController.addAction(firstOptionAction)
        
        let secondOptionAction = UIAlertAction(title: dilemma?.secondOption.title, style: .default) { (action) in
            GlobalSimulationManager.shared.select(option: .option2, of: dilemma!)
        }
        alertController.addAction(secondOptionAction)
        
        alertController.view.tintColor = App.Color.alertControllerTintColor
        alertController.view.backgroundColor = App.Color.alertControllerBackgroundColor
        
        present(alertController, animated: true, completion: nil)
    }
}

extension DashboardViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

        return self.viewModel?.turn(in: section)?.title
    }

    private func tableView (tableView: UITableView, heightForHeaderInSection section: Int) -> Float {
        
        return 20.0
    }

    func numberOfSections(in tableView: UITableView) -> Int {

        return self.viewModel?.turns() ?? 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return self.viewModel?.events(in: section) ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DashboardViewController.reuseableIdentifier, for: indexPath)

        let event = self.viewModel?.event(at: indexPath)

        cell.imageView?.image = event?.image
        cell.textLabel?.text = event?.title
        cell.detailTextLabel?.text = event?.summary

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
}
