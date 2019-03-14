//
//  Events.swift
//  SmartSimulationFramework
//
//  Created by Michael Rommel on 24.10.18.
//  Copyright © 2018 Michael Rommel. All rights reserved.
//

import Foundation

public class Events {

	public var earthQuakeEvent: Earthquake
	public var monumentVandalizedEvent: MonumentVandalized
	public var ministerialScandal: MinisterialScandal
    public var povertyReport: PovertyReport

	fileprivate var events: [Event] = []

	init() {
		self.earthQuakeEvent = Earthquake()
		self.monumentVandalizedEvent = MonumentVandalized()
		self.ministerialScandal = MinisterialScandal()
        self.povertyReport = PovertyReport()
	}

	func setup(with global: GlobalSimulation) {

		self.earthQuakeEvent.setup(with: global)
		self.monumentVandalizedEvent.setup(with: global)
		self.ministerialScandal.setup(with: global)
        self.povertyReport.setup(with: global)
	}

	func add(event: Event) {

		self.events.append(event)
	}

	func calculate() {

		self.events.forEach { $0.calculate() }
	}

	func push() {

		self.events.forEach { $0.push() }
	}

	func findBestEvent(with global: GlobalSimulation) -> Event? {

		let maxScore = self.events.max(by: { $0.value() < $1.value() })?.value() ?? 0
        
        guard maxScore > 0.7 else {
            // highest score must be above 70%, otherwise the dilemmas step in
            return nil
        }
        
		let allEventsWithMaxScore = self.events.filter { $0.value() == maxScore }

		if !allEventsWithMaxScore.isEmpty {

			let eventThatTriggered = allEventsWithMaxScore.randomItem()

			return eventThatTriggered
		}

		return nil
	}
}

extension Events: Sequence {
    
    public struct EventsIterator: IteratorProtocol {
        
        private var index = 0
        private let events: [Event]
        
        init(events: [Event]) {
            self.events = events
        }
        
        mutating public func next() -> Event? {
            let event = self.events[safe: index]
            index += 1
            return event
        }
    }
    
    public func makeIterator() -> EventsIterator {
        return EventsIterator(events: self.events)
    }
}
