//
//  SimulationDetailViewController.swift
//  Simulation
//
//  Created by Michael Rommel on 08.02.19.
//  Copyright © 2019 Michael Rommel. All rights reserved.
//

import UIKit
import Rswift

class SimulationDetailViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var simulationDetailViewModel: DetailViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard simulationDetailViewModel != nil else {
            fatalError("Model must be initialized before display")
        }

        // Do any additional setup after loading the view.
        self.title = self.simulationDetailViewModel?.name
        self.view.backgroundColor = App.Color.viewBackgroundColor

        self.simulationDetailViewModel?.delegate = self
        
        self.tableView.delegate = self
        self.tableView.dataSource = self

        self.tableView.register(TableViewNameCell.self)
        self.tableView.register(TableViewDescriptionCell.self)
        self.tableView.register(TableViewCategoryCell.self)
        self.tableView.register(TableViewValueCell.self)
        self.tableView.register(TableViewRelationCell.self)

        self.tableView.tableFooterView = UIView()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension SimulationDetailViewController: ViewModelDelegate {
    
    func willLoadData() {
        
    }
    
    func didLoadData() {
        
        self.tableView.reloadData()
    }
}

extension SimulationDetailViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return nil
        case 1:
            return R.string.localizable.simulationDetailViewControllerSectionInput()
        case 2:
            return R.string.localizable.simulationDetailViewControllerSectionOutput()
        default:
            return nil
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 4
        case 1:
            return self.simulationDetailViewModel?.inputIdentifiers.count ?? 0
        case 2:
            return self.simulationDetailViewModel?.outputIdentifiers.count ?? 0
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
        case 2:
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
                cell.setup(with: self.simulationDetailViewModel)
                return cell
            case 1:
                let cell: TableViewDescriptionCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
                cell.setup(with: self.simulationDetailViewModel)
                return cell
            case 2:
                let cell: TableViewCategoryCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
                cell.setup(with: self.simulationDetailViewModel)
                return cell
            case 3:
                let cell: TableViewValueCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
                cell.setup(with: self.simulationDetailViewModel)
                return cell
            default:
                return UITableViewCell()
            }
        case 1:
            let cell: TableViewRelationCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.setup(with: self.simulationDetailViewModel?.getInputRelation(at: indexPath.row))
            return cell
        case 2:
            let cell: TableViewRelationCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.setup(with: self.simulationDetailViewModel?.getOutputRelation(at: indexPath.row))
            return cell
        default:
            return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.tableView.deselectRow(at: indexPath, animated: true)
        self.simulationDetailViewModel?.selectDetail(at: indexPath, from: self)
    }
}
