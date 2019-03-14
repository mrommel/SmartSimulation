//
//  PovertyReport.swift
//  SmartSimulationFramework
//
//  Created by Michael Rommel on 14.03.19.
//  Copyright © 2019 Michael Rommel. All rights reserved.
//

import Foundation

public class PovertyReport: Event {
    
    init() {
        super.init(
            identifier: "PovertyReport",
            image: nil,
            name: "PovertyReport",
            summary: "The international commission for equality has issued a report that’s truly damning of your governments inability to control inequality. Your government has been singled out as one of the least egalitarian in the world which is causing outrage in the liberal and socialist press.",
            category: .welfare)
    }
    
    override func effects(for global: GlobalSimulation?) -> [Effect] {
        
        //CreateGrudge(Poverty Report,PovertyReport,Socialist,-0.500,0.650);
        //CreateGrudge(Poverty Report,PovertyReport,TradeUnionist,-0.400,0.640);
        
        let effectOnLiberals = Effect(name: "PovertyReport effect on Liberal", value: -0.12, decay: 0.75)
        global?.groups.conservatives.mood.add(simulation: effectOnLiberals, formula: "x")
        
        let decayEffect = Effect(name: "PovertyReport decay", value: -0.9, decay: 0.9) //
        global?.events.povertyReport.add(simulation: decayEffect)
        
        return [effectOnLiberals, decayEffect]
    }
    
    override func setup(with global: GlobalSimulation) {
        
        self.add(simulation: RandomProperty(minimum: 0.15, maximum: 0.3))
        self.add(simulation: global.simulations.povertyRate, formula: "0+(x^4)")
        
        global.events.add(event: self)
    }
}
