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

struct GlobalSimulationEvent {
    
    let image: UIImage?
    let title: String
    let summary: String
}

protocol GlobalSimulationEventLogDelegate {
    func didAddEvent()
}

class GlobalSimulationEventLog {
    
    var events: [GlobalSimulationEvent]
    var delegate: GlobalSimulationEventLogDelegate?
    
    init() {
        self.events = []
    }
    
    func addEvent(with image: UIImage?, title: String, and summary: String) {
        self.events.prepend(GlobalSimulationEvent(image: image, title: title, summary: summary))
        delegate?.didAddEvent()
    }
}

class GlobalSimulationManager {
    
    static let shared = GlobalSimulationManager()
    
    private var globalSimulation: GlobalSimulation?
    var eventLog: GlobalSimulationEventLog?
    
    private init() {
        self.globalSimulation = GlobalSimulation(tileInfo: TileInfo(terrain: TerrainInfo.grassland, features: [FeatureInfo.hill]))
        self.eventLog = GlobalSimulationEventLog()
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
}

extension GlobalSimulationManager: GlobalSimulationDelegate {
    
    func iterationComplete() {
        print("iterationComplete")
        eventLog?.addEvent(with: R.image.turn(), title: "New Iteration", and: "We have now ####")
        logw("iterationComplete")
    }
    
    func triggered(event: Event?) {
        if let event = event {
            print("triggered: \(event)")
            eventLog?.addEvent(with: R.image.event(), title: "New Event", and: "\(event.name)")
            logw("triggered: \(event)")
        }
    }
    
    func invented(technic: Technic?) {
        if let technic = technic {
            print("invented: \(technic)")
            eventLog?.addEvent(with: R.image.innovation(), title: "New Technic", and: "\(technic.name) invented")
            logw("invented: \(technic)")
        }
    }
    
    func started(situation: Situation?) {
        if let situation = situation {
            print("started: \(situation)")
            eventLog?.addEvent(with: R.image.bell(), title: "New Situation started", and: "\(situation.name)")
            logw("started: \(situation)")
        }
    }
    
    func ended(situation: Situation?) {
        if let situation = situation {
            print("ended: \(situation)")
            eventLog?.addEvent(with: R.image.bell(), title: "Situation ended", and: "\(situation.name)")
            logw("ended: \(situation)")
        }
    }
}
