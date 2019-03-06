//
//  PolicyDetailViewController.swift
//  Simulation
//
//  Created by Michael Rommel on 04.03.19.
//  Copyright © 2019 Michael Rommel. All rights reserved.
//

import UIKit
import SmartSimulationFramework
import Rswift

class PolicyDetailViewController: UIViewController {
    
    static let reuseIdentifier: String = "policyCell"
    
    @IBOutlet weak var tableView: UITableView!
    
    var policyDetailViewModel: DetailViewModel?
    
    lazy var standardCell: UITableViewCell = {
        if let cell = tableView.dequeueReusableCell(withIdentifier: PolicyDetailViewController.reuseIdentifier) {
            return cell
        } else {
            return UITableViewCell(style: .default, reuseIdentifier: PolicyDetailViewController.reuseIdentifier)
        }
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.title = self.policyDetailViewModel?.name
        self.view.backgroundColor = App.Color.viewBackgroundColor
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.register(TableViewNameCell.self)
        self.tableView.register(TableViewDescriptionCell.self)
        self.tableView.register(TableViewCategoryCell.self)
        self.tableView.register(TableViewRelationCell.self)
        
        self.tableView.tableFooterView = UIView()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension PolicyDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return nil
        case 1:
            return R.string.localizable.policyDetailViewControllerSectionOutput()
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 4
        case 1:
            return self.policyDetailViewModel?.outputs.count ?? 0
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                return 60
            case 1:
                return 140
            case 2:
                return 60
            case 3:
                return 60
            default:
                return 60
            }
        case 1:
            return 60
        default:
            return 0
        }
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                let cell: TableViewNameCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
                cell.setup(with: self.policyDetailViewModel)
                return cell
            case 1:
                let cell: TableViewDescriptionCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
                cell.setup(with: self.policyDetailViewModel)
                return cell
            case 2:
                let cell: TableViewCategoryCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
                cell.setup(with: self.policyDetailViewModel)
                return cell
            case 3:
                let cell = self.standardCell
                
                if let policyDetailViewModel = self.policyDetailViewModel as? PolicyDetailViewModel {
                    cell.textLabel?.text = policyDetailViewModel.policy?.selection.name
                }
                //cell.accessoryType = .disclosureIndicator
                //cell.tintColor = App.Color.tableViewCellAccessoryColor
                let disclosureIndicatorView = DisclosureIndicatorView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
                disclosureIndicatorView.color = App.Color.tableViewCellAccessoryColor
                //disclosureIndicatorView.tintColor = App.Color.tableViewCellAccessoryColor
                cell.accessoryView = disclosureIndicatorView
                return cell
            default:
                return UITableViewCell()
            }
        case 1:
            let cell: TableViewRelationCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.setup(with: self.policyDetailViewModel?.getOutputRelation(at: indexPath.row))
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 0 && indexPath.row == 3 {
            if let policyDetailViewModel = self.policyDetailViewModel as? PolicyDetailViewModel {
                
                let viewController = PolicySelectionController(title: policyDetailViewModel.name,
                                                               data: policyDetailViewModel.policy?.selections,
                                                               selectedIndex: policyDetailViewModel.policy?.selectedIndex,
                                                               onSelect:
                    { newSelection in
                    
                        // TODO: move to model
                        policyDetailViewModel.policy?.selection = newSelection
                        self.tableView.reloadData()
                    })
                self.navigationController?.pushViewController(viewController, animated: true)
            }
        }
    }
}
