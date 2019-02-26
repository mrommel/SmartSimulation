//
//  SettingsViewModel.swift
//  Simulation
//
//  Created by Michael Rommel on 21.02.19.
//  Copyright © 2019 Michael Rommel. All rights reserved.
//

import UIKit
import SwiftLog

class SettingItem {
    
    let title: String
    let enabled: Bool
    var completionHandler: () -> Void = { }
    
    init(title: String, enabled: Bool, completionHandler: @escaping () ->Void) {
        self.title = title
        self.enabled = enabled
        self.completionHandler = completionHandler
    }
    
    func execute() {
        self.completionHandler()
    }
}

class SettingsViewModel: ViewModelType {
    
    var delegate: ViewModelDelegate?
    var settingItems: [SettingItem]
    
    lazy var bundle: Bundle = Bundle.main
    
    init() {
        self.settingItems = []
    }
    
    func reload() {
        self.settingItems = []
        self.settingItems.append(SettingItem(title: "Über SmartSimulation", enabled: true, completionHandler: {
            
            let currentVersion = self.bundle.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
            self.delegate?.showAlertText(title: "Version", text: "\(currentVersion)")
        }))
        
        // debug
        let applicationLaunch = ApplicationLaunch()
        self.settingItems.append(SettingItem(title: "Reset first use", enabled: applicationLaunch.launchCount > 0, completionHandler: {
            applicationLaunch.reset()
            self.bootstrap()
        }))
        
        self.settingItems.append(SettingItem(title: "Eventlog", enabled: true, completionHandler: {
            
            self.delegate?.showAlertText(title: "Log", text: Log.logger.readAll())
        }))
    }
    
    func bootstrap() {
        self.reload()
        self.delegate?.didLoadData()
    }
    
    func settingCount() -> Int {
        return self.settingItems.count
    }
    
    func settingItem(at index: Int) -> SettingItem {
        return self.settingItems[index]
    }
    
    func clickSettingItem(at index: Int) {
        
        let settingItem = self.settingItem(at: index)
        
        if settingItem.enabled {
            settingItem.execute()
        }
        
        self.reload()
    }
}
