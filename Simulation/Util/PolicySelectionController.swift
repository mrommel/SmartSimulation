//
//  UserSelectionController.swift
//  Simulation
//
//  Created by Michael Rommel on 04.03.19.
//  Copyright © 2019 Michael Rommel. All rights reserved.
//

import UIKit
import SmartSimulationFramework

class PolicySelectionController: UITableViewController {
    
    let reuseIdentifier: String = "optionCell"
    var data: [PolicySelection]?
    var selectedIndex: Int? = nil
    let onSelect: (PolicySelection) -> ()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Not implemented")
    }
    
    init(title: String, data: [PolicySelection]?, selectedIndex: Int?, onSelect: @escaping (PolicySelection) -> ()) {

        self.data = data
        self.selectedIndex = selectedIndex
        self.onSelect = onSelect
        
        super.init(style: .grouped)
        
        self.title = title
    }
    
    // MARK: table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) {
            return cell
        } else {
            return UITableViewCell(style: .default, reuseIdentifier: reuseIdentifier)
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if let option = self.data?[indexPath.row] {
            cell.textLabel?.text = option.name
            cell.detailTextLabel?.text = option.description
        } 
        
        cell.tintColor = App.Color.tableViewCellAccessoryColor
        cell.accessoryType = self.selectedIndex == indexPath.row ? .checkmark : .none
    }
    
    // MARK: table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // remove checkmark for the old selected cell
        if let oldSelectionIndex = self.selectedIndex {
            let oldSelectionIndexPath = IndexPath(row: oldSelectionIndex, section: 0)
            tableView.cellForRow(at: oldSelectionIndexPath)?.accessoryType = .none
        }
        
        // update the selection
        if let option = self.data?[indexPath.row] {
            self.selectedIndex = indexPath.row
            self.onSelect(option)
        }
        
        // add a checkmark to the selected row and deselect it
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
