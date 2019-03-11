//
//  GlobalSimulationManager.swift
//  Simulation
//
//  Created by Michael Rommel on 14.02.19.
//  Copyright © 2019 Michael Rommel. All rights reserved.
//

import Foundation
import SmartSimulationFramework
import SwiftLog

protocol GlobalSimulationInteractionDelegate {
    
    func showAlert(for event: Event?)
    func showAlert(for dilemma: Dilemma?)
}

class GlobalSimulationManager {
    
    static let shared = GlobalSimulationManager()
    
    private var globalSimulation: GlobalSimulation?
    var eventLog: GlobalSimulationEventLog?
    var year: Int = -500
    
    var delegate: GlobalSimulationInteractionDelegate?
    
    private init() {
        self.globalSimulation = GlobalSimulation(tileInfo: TileInfo(terrain: TerrainInfo.grassland, features: [FeatureInfo.hill]))
        self.eventLog = GlobalSimulationEventLog()
        
        self.eventLog?.doTurn(with: self.year)
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
    
    func groups() -> Groups? {
        return self.globalSimulation?.groups
    }
    
    func situations() -> Situations? {
        return self.globalSimulation?.situations
    }
    
    func policies() -> Policies? {
        return self.globalSimulation?.policies
    }
    
    func select(of event: Event) {
        self.globalSimulation?.select(of: event)
    }
    
    func select(option: DilemmaOptionType, of dilemma: Dilemma) {
        self.globalSimulation?.select(option: option, of: dilemma)
        
        self.eventLog?.addEvent(for: dilemma, option: option)
    }
    
    func voters() -> Voters? {
        return self.globalSimulation?.voters
    }
}

extension GlobalSimulationManager: GlobalSimulationDelegate {
    
    func iterationComplete() {
        self.year += 5
        self.eventLog?.doTurn(with: self.year)
        logw("iterationComplete")
    }
    
    func triggered(event: Event?) {
        if let event = event {
            logw("triggered: \(event)")
            self.delegate?.showAlert(for: event)
            self.eventLog?.addEvent(for: event)
        }
    }
    
    func triggered(dilemma: Dilemma?) {
        if let dilemma = dilemma {
            logw("triggered: \(dilemma)")
            self.delegate?.showAlert(for: dilemma)
        }
    }
    
    func invented(technic: Technic?) {
        if let technic = technic {
            logw("invented: \(technic)")
            self.eventLog?.addEvent(for: technic)
        }
    }
    
    func started(situation: Situation?) {
        if let situation = situation {
            logw("started: \(situation)")
            self.eventLog?.addEvent(for: situation, type: .started)
        }
    }
    
    func ended(situation: Situation?) {
        if let situation = situation {
            logw("ended: \(situation)")
            self.eventLog?.addEvent(for: situation, type: .ended)
        }
    }
}
