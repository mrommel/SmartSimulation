//
//  GlobalSimulationEventLog.swift
//  Simulation
//
//  Created by Michael Rommel on 11.03.19.
//  Copyright © 2019 Michael Rommel. All rights reserved.
//

import UIKit
import SmartSimulationFramework
import Rswift

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
            self.addEvent(with: R.image.bell(),
                          title: R.string.localizable.dashboardViewControllerEventsSituationStarted(),
                          and: situation.name)
        } else {
            self.addEvent(with: R.image.bell(),
                          title: R.string.localizable.dashboardViewControllerEventsSituationEnded(),
                          and: situation.name)
        }
    }
    
    func addEvent(for dilemma: Dilemma, option: DilemmaOptionType) {
        
        if option == .option1 {
            self.addEvent(with: R.image.dilemma(),
                          title: "\(dilemma.name) \(R.string.localizable.dashboardViewControllerEventsDilemmaHappend())",
                          and: "\(dilemma.firstOption.title) \(R.string.localizable.dashboardViewControllerEventsDilemmaSelected())")
        } else {
            self.addEvent(with: R.image.dilemma(),
                          title: "\(dilemma.name) \(R.string.localizable.dashboardViewControllerEventsDilemmaHappend())",
                          and: "\(dilemma.secondOption.title) \(R.string.localizable.dashboardViewControllerEventsDilemmaSelected())")
        }
        self.delegate?.didAddEvent()
    }
    
    func addEvent(for event: Event) {
        
        self.addEvent(with: R.image.event(),
                      title: R.string.localizable.dashboardViewControllerEventsEventNew(),
                      and: event.name)
    }
    
    func addEvent(for technic: Technic) {
        
        self.addEvent(with: R.image.innovation(),
                      title: R.string.localizable.dashboardViewControllerEventsTechnicNew(),
                      and: "\(technic.name) \(R.string.localizable.dashboardViewControllerEventsTechnicInvented())")
    }
    
    func doTurn(with year: Int) {
        
        self.turns.prepend(GlobalSimulationTurn(title: "We have now \(year)"))
        self.delegate?.didAddEvent()
    }
}
