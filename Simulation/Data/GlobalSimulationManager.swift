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

class GlobalSimulationTurn {
    
    let title: String
    var events: [GlobalSimulationEvent] = []
    
    init(title: String) {
        self.title = title
    }
}

struct GlobalSimulationEvent {
    
    let image: UIImage?
    let title: String
    let summary: String
}

protocol GlobalSimulationEventLogDelegate {
    
    func didAddEvent()
}

enum SituationEventType {
    case started
    case ended
}

class GlobalSimulationEventLog {
    
    var turns: [GlobalSimulationTurn]
    var delegate: GlobalSimulationEventLogDelegate?
    
    init() {
        self.turns = []
    }
    
    fileprivate func addEvent(with image: UIImage?, title: String, and summary: String) {
        
        self.turns.first?.events.prepend(GlobalSimulationEvent(image: image, title: title, summary: summary))
    }
    
    func addEvent(for situation: Situation, type: SituationEventType) {
        
        if type == .started {
            self.addEvent(with: R.image.bell(), title: "New Situation started", and: "\(situation.name)")
        } else {
            self.addEvent(with: R.image.bell(), title: "Situation ended", and: "\(situation.name)")
        }
    }
    
    func addEvent(for dilemma: Dilemma, option: DilemmaOptionType) {
        
        if option == .option1 {
            self.addEvent(with: R.image.dilemma(), title: "\(dilemma.name) happend", and: "\(dilemma.firstOption.title) selected")
        } else {
            self.addEvent(with: R.image.dilemma(), title: "\(dilemma.name) happend", and: "\(dilemma.secondOption.title) selected")
        }
        self.delegate?.didAddEvent()
    }
    
    func addEvent(for event: Event) {
        
        self.addEvent(with: R.image.event(), title: "New Event", and: "\(event.name)")
    }
    
    func addEvent(for technic: Technic) {
        
        self.addEvent(with: R.image.innovation(), title: "New Technic", and: "\(technic.name) invented")
    }
    
    func doTurn(with title: String) {
        
        self.turns.prepend(GlobalSimulationTurn(title: title))
        self.delegate?.didAddEvent()
    }
}

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
        
        self.eventLog?.doTurn(with: "We have now \(self.year)")
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
        self.eventLog?.doTurn(with: "We have now \(self.year)")
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
