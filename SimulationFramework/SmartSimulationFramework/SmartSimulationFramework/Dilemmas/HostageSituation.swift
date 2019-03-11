//
//  HostageSituation.swift
//  SmartSimulationFramework
//
//  Created by Michael Rommel on 11.03.19.
//  Copyright © 2019 Michael Rommel. All rights reserved.
//

import Foundation

public class HostageSituation: Dilemma {
    
    init() {
        super.init(
            image: nil,
            name: "Hostage Situation",
            summary: "A group of religious extremists have taken some hostages at gunpoint and are threatening to kill them unless demands regarding foreign policy are not met. The demands they make are not that extreme, but it might be dangerous to be seen to negotiate.",
            category: .religion,
            firstOption: DilemmaOption(optionType: .option1, title: "Give in to demands", summary: "The best thing we can do here is to be reasonable and give in at least partially to their demands. That way we can ensure nobody gets hurt, and the situation doesn't spiral out of control. Taking extreme action against these people could only cause racial tension."),
            secondOption: DilemmaOption(optionType: .option2, title: "Send in the police", summary: "There is no negotiating with hostage takers. To do so would open the floodgates to total chaos. Its unfortunate for those citizens taken hostage, but we need to storm the building right now and try and get those people freed. If that means shooting the hostage takers and losing a few hostages, that's the price we have to pay."))
    }
    
    override func setup(with global: GlobalSimulation) {
        
        self.add(simulation: StaticProperty(value: 0.3))
        self.add(simulation: global.simulations.crimeRate, formula: "0.6*x")
        
        global.dilemmas.add(dilemma: self)
    }
    
    override func effectsOf(optionType: DilemmaOptionType, for global: GlobalSimulation?) -> [Effect] {
        if optionType == .option1 {
            
            // +15% Religious relations
            let effectOnReligious = Effect(name: "HostageSituation effect on Liberals", value: 1.0, decay: 0.8)
            global?.groups.liberals.mood.add(simulation: effectOnReligious, formula: "0.15*x")

            // +30% Terrorism
            let effectOnTerrorism = Effect(name: "HostageSituation effect on Terrorism", value: 1.0, decay: 0.8)
            global?.simulations.terrorism.add(simulation: effectOnTerrorism, formula: "0.3*x")
            
            let decayEffect = Effect(name: "HostageSituation decay", value: -1.0, decay: 0.9) //
            global?.dilemmas.blasphemyDilemma.add(simulation: decayEffect)
            
            return [effectOnReligious, effectOnTerrorism, decayEffect]
        } else {
            
            // -15% Liberal relations
            let effectOnLiberals = Effect(name: "HostageSituation effect on Liberals", value: 1.0, decay: 0.8)
            global?.groups.liberals.mood.add(simulation: effectOnLiberals, formula: "-0.15*x")
            
            // -15% Religious relations
            let effectOnReligious = Effect(name: "HostageSituation effect on Religious", value: 1.0, decay: 0.8)
            global?.groups.religious.mood.add(simulation: effectOnReligious, formula: "-0.15*x")
            
            let decayEffect = Effect(name: "HostageSituation decay", value: -1.0, decay: 0.9) //
            global?.dilemmas.blasphemyDilemma.add(simulation: decayEffect)
            
            return [effectOnLiberals, effectOnReligious, decayEffect]
        }
    }
}
