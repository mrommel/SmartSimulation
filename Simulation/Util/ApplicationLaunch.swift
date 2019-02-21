//
//  ApplicationLaunch.swift
//  Simulation
//
//  Created by Michael Rommel on 21.02.19.
//  Copyright © 2019 Michael Rommel. All rights reserved.
//

import Foundation

protocol ApplicationLaunchDelegate {
    
    func applicationFirstLaunch()
    func applicationDidUpgrade(from: String, to: String)
    func applicationNormalLaunch()
}

final class ApplicationLaunch {
    
    private struct Keys {
        static let appLaunchCount = "com.miro.SmartSimulation.appLaunchCount"
        static let appLastLaunchVersion = "com.miro.SmartSimulation.appLastLaunchVersion"
    }
    
    lazy var bundle: Bundle = Bundle.main
    lazy var userDefaults: UserDefaults = UserDefaults.standard
    
    var delegate: ApplicationLaunchDelegate?
    
    func evaluate() {
        
        var normal = true
        
        // Try to detect first launch
        if self.launchCount == 0 {
            print("...first launch detected")
            self.delegate?.applicationFirstLaunch()
            normal = false
        }
        
        // Update app launches count
        self.launchCount += 1
        print("...\(launchCount) launches")
        
        // Try to detect version upgrade
        let currentVersion = bundle.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
        if let lastLaunchVersion = lastLaunchVersion, currentVersion != lastLaunchVersion {
            print("...upgrade detected")
            self.delegate?.applicationDidUpgrade(from: lastLaunchVersion, to: currentVersion)
            normal = false
        }
        
        // Update last known version if new
        if self.lastLaunchVersion != currentVersion {
            print("...saving new version: \(currentVersion)")
            self.lastLaunchVersion = currentVersion
        }
        
        // Make sure user defaults are saved
        self.userDefaults.synchronize()
        
        // only if not first nor upgrade, launch normal
        if normal {
            self.delegate?.applicationNormalLaunch()
        }
    }
    
    // MARK: - Utilities
    
    private(set) var lastLaunchVersion: String? {
        get {
            return self.userDefaults.string(forKey: Keys.appLastLaunchVersion)
        }
        set {
            if let newValue = newValue {
                self.userDefaults.set(newValue, forKey: Keys.appLastLaunchVersion)
            } else {
                self.userDefaults.removeObject(forKey: Keys.appLastLaunchVersion)
            }
        }
    }
    
    private(set) var launchCount: Int {
        get {
            return self.userDefaults.integer(forKey: Keys.appLaunchCount)
        }
        set {
            self.userDefaults.set(newValue, forKey: Keys.appLaunchCount)
        }
    }
    
    func reset() {
        
        self.lastLaunchVersion = nil // reset
        self.launchCount = 0
        
        // Make sure user defaults are saved
        self.userDefaults.synchronize()
    }
}
