//
//  SituationDetailViewController.swift
//  Simulation
//
//  Created by Michael Rommel on 04.03.19.
//  Copyright © 2019 Michael Rommel. All rights reserved.
//

import UIKit
import Rswift

class SituationDetailViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var situationDetailViewModel: DetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.title = self.situationDetailViewModel?.name
        self.view.backgroundColor = App.Color.viewBackgroundColor
        
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

extension SituationDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return nil
        case 1:
            return R.string.localizable.situationDetailViewControllerSectionInput()
        case 2:
            return R.string.localizable.situationDetailViewControllerSectionOutput()
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 4
        case 1:
            return self.situationDetailViewModel?.inputs.count ?? 0
        case 2:
            return self.situationDetailViewModel?.outputs.count ?? 0
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
                cell.setup(with: self.situationDetailViewModel)
                return cell
            case 1:
                let cell: TableViewDescriptionCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
                cell.setup(with: self.situationDetailViewModel)
                return cell
            case 2:
                let cell: TableViewCategoryCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
                cell.setup(with: self.situationDetailViewModel)
                return cell
            case 3:
                let cell: TableViewValueCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
                cell.setup(with: self.situationDetailViewModel)
                return cell
            default:
                return UITableViewCell()
            }
        case 1:
            let cell: TableViewRelationCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.setup(with: self.situationDetailViewModel?.getInputRelation(at: indexPath.row))
            return cell
        case 2:
            let cell: TableViewRelationCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.setup(with: self.situationDetailViewModel?.getOutputRelation(at: indexPath.row))
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
}
