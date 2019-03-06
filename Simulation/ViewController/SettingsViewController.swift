//
//  SettingsViewController.swift
//  Simulation
//
//  Created by Michael Rommel on 21.02.19.
//  Copyright © 2019 Michael Rommel. All rights reserved.
//

import UIKit
import Rswift

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private static let reuseableIdentifier = "SettingCell"
    
    var viewModel: SettingsViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // initialize the view model
        self.viewModel = SettingsViewModel()
        self.viewModel?.delegate = self
        self.viewModel?.bootstrap()
        
        // Do any additional setup after loading the view, typically from a nib.
        self.title = R.string.localizable.settingsViewControllerTitle()
        self.view.backgroundColor = App.Color.viewBackgroundColor
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

// notifications from the view model
extension SettingsViewController: ViewModelDelegate {
    
    func willLoadData() {
        
    }
    
    func didLoadData() {
        self.tableView.reloadData()
        //self.refreshControl.endRefreshing()
    }
    
    func showAlertText(title: String, text: String) {
        let alert = UIAlertController(title: title, message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.settingCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingsViewController.reuseableIdentifier, for: indexPath)
        
        let settingItem = self.viewModel?.settingItem(at: indexPath.row)
        
        if let enabled = settingItem?.enabled {
            if enabled {
                cell.selectionStyle = .blue
                cell.textLabel?.text = settingItem?.title
                cell.textLabel?.textColor = App.Color.tableViewCellTextEnabledColor
            } else {
                cell.selectionStyle = .none
                cell.textLabel?.text = settingItem?.title
                cell.textLabel?.textColor = App.Color.tableViewCellTextDisabledColor
            }
        }

        return cell
    }
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewModel?.clickSettingItem(at: indexPath.row)
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
}
