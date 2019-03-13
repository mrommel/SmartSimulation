//
//  Simulation.swift
//  agents
//
//  Created by Michael Rommel on 04.09.18.
//  Copyright © 2018 Michael Rommel. All rights reserved.
//

import Foundation

public enum TerrainInfo: CaseIterable {

    case ocean
    case shore
    case plain
    case grassland
    case desert
    case swamp
    case tundra
}

public enum FeatureInfo: CaseIterable {

    case forest
    case rainforest
    case hill
    case mountain
    case isle
}

public enum ResourceInfo: CaseIterable {

    case coal
    case ironore
    case copperore
}

public class TileInfo {

    let terrain: TerrainInfo
    let features: [FeatureInfo]
    let resource: ResourceInfo?

    public init(terrain: TerrainInfo, features: [FeatureInfo]) {
        self.terrain = terrain
        self.features = features
        self.resource = Double.random(minimum: 0.0, maximum: 1.0) < 0.1 ? ResourceInfo.allCases.randomItem() : nil
    }

    var mineralsPropability: Double {

        var value = 0.0

        if self.terrain == .desert {
            value = 0.1
        }

        if self.resource != nil {
            value += 0.2
        }

        return value
    }

    var animalsPropability: Double {

        var value = 0.0

        if self.terrain == .desert {
            value = 0.1
        }

        if self.features.contains(.hill) || self.features.contains(.rainforest) {
            value += 0.1
        }

        if self.features.contains(.forest) {
            value += 0.2
        }

        return value
    }
}

public protocol GlobalSimulationDelegate: class {

    func iterationComplete()

    func triggered(event: Event?)
    func triggered(dilemma: Dilemma?)
    func invented(technic: Technic?)
    func started(situation: Situation?)
    func ended(situation: Situation?)
}

public class GlobalSimulation {

    public let tileInfo: TileInfo

    public var simulations: Simulations
    public var policies: Policies
    public var events: Events
    public var dilemmas: Dilemmas
    public var groups: Groups
    public var situations: Situations
    public var technics: Technics
    var effects: Effects
    public var voters: Voters

    public weak var delegate: GlobalSimulationDelegate?

    public init(tileInfo: TileInfo) {

        self.tileInfo = tileInfo

        // init
        self.simulations = Simulations()
        self.policies = Policies()
        self.events = Events()
        self.dilemmas = Dilemmas()
        self.groups = Groups()
        self.situations = Situations()
        self.technics = Technics()
        self.effects = Effects()
        self.voters = Voters()

        // setup
        self.simulations.setup(with: self)
        self.policies.setup(with: self)
        self.events.setup(with: self)
        self.dilemmas.setup(with: self)
        self.groups.setup(with: self)
        self.situations.setup(with: self)
        self.technics.setup(with: self)
        self.voters.setup(with: self)
    }

    public func iterate() {
        DispatchQueue.global(qos: .userInitiated).async {
            // perform expensive task
            self.doIterate()

            DispatchQueue.main.async {
                // Update the UI
                self.delegate?.iterationComplete()
            }
        }
    }

    private func doIterate() {

        // first we need to do the calculation
        self.technics.evaluate()
        self.simulations.calculate()
        self.policies.calculate()
        self.events.calculate()
        self.dilemmas.calculate()
        self.groups.calculate()
        self.situations.calculate()
        self.effects.calculate()

        // find event
        if let event = self.events.findBestEvent(with: self) {
            DispatchQueue.main.async {
                // Inform the UI
                self.delegate?.triggered(event: event)
            }
        } else if let dilemma = self.dilemmas.findBestDilemma(with: self) { // else find best dilemma
            DispatchQueue.main.async {
                // Inform the UI
                self.delegate?.triggered(dilemma: dilemma)
            }
        }

        // then we need to push the value
        self.simulations.push()
        self.policies.push()
        self.events.push()
        self.dilemmas.push()
        self.groups.push()
        self.situations.push()
        self.effects.push()

        // filter effects that are too small
        self.effects.reduce()
    }

    public func select(of event: Event) {
        let newEffects = event.effects(for: self)
        newEffects.forEach { $0.calculate() }
        self.effects.add(effects: newEffects)
    }

    public func select(option: DilemmaOptionType, of dilemma: Dilemma) {
        let newEffects = dilemma.effectsOf(optionType: option, for: self)
        newEffects.forEach { $0.calculate() }
        self.effects.add(effects: newEffects)
    }
    
    public func simulation(by identifier: String) -> Simulation? {
        
        return simulations.first { $0.identifier == identifier }
    }
}

extension GlobalSimulation: SituationDelegate {

    public func start(situation: Situation?) {
        if let situation = situation {
            DispatchQueue.main.async {
                // Inform the UI
                self.delegate?.started(situation: situation)
            }
        }
    }

    public func end(situation: Situation?) {
        if let situation = situation {
            DispatchQueue.main.async {
                // Inform the UI
                self.delegate?.ended(situation: situation)
            }
        }
    }
}

extension GlobalSimulation: TechnicDelegate {

    public func invented(technic: Technic?) {
        if let technic = technic {
            DispatchQueue.main.async {
                // Inform the UI
                self.delegate?.invented(technic: technic)
            }
        }
    }
}
