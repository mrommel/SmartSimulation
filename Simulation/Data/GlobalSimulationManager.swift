//
//  GlobalSimulationManager.swift
//  Simulation
//
//  Created by Michael Rommel on 14.02.19.
//  Copyright © 2019 Michael Rommel. All rights reserved.
//

import Foundation
import SmartSimulationFramework

class GlobalSimulationManager {
    
    static let shared = GlobalSimulationManager()
    
    private var globalSimulation: GlobalSimulation?
    
    private init() {
        self.globalSimulation = GlobalSimulation(tileInfo: TileInfo(terrain: TerrainInfo.grassland, features: [FeatureInfo.hill]))
    }
    
    func iterate() {
        self.globalSimulation?.iterate()
    }
    
    func setup() {
        self.globalSimulation?.delegate = self
    }
    
    func simulations() -> Simulations? {
        return self.globalSimulation?.simulations
    }
}

extension GlobalSimulationManager: GlobalSimulationDelegate {
    
    func iterationComplete() {
        print("iterationComplete")
    }
    
    func triggered(event: Event?) {
        if let event = event {
            print("triggered: \(event)")
        }
    }
    
    func invented(technic: Technic?) {
        if let technic = technic {
            print("invented: \(technic)")
        }
    }
    
    func started(situation: Situation?) {
        if let situation = situation {
            print("started: \(situation)")
        }
    }
    
    func ended(situation: Situation?) {
        if let situation = situation {
            print("ended: \(situation)")
        }
    }
}
