//
//  Blasphemy.swift
//  SmartSimulationFramework
//
//  Created by Michael Rommel on 26.02.19.
//  Copyright © 2019 Michael Rommel. All rights reserved.
//

import Foundation

public class Blasphemy: Dilemma {
    
    init() {
        super.init(
            identifier: "Blasphemy",
            image: nil,
            name: "Blasphemy",
            summary: "A book has been published which is highly critical of a religion followed by a cross section of our society. Religious leaders have described the book as blasphemy and demanded that it be removed from sale. There have been violent protests outside bookstores where copies of the book have been burned.",
            category: .religion,
            firstOption: DilemmaOption(optionType: .option1, title: "Ban the Book", summary: "This book is highly offensive and we should take into account the views of our ethnic minorities. Its entirely reasonable to restrict the sale of material like this which is likely to cause a public disturbance. Ban the book."),
            secondOption: DilemmaOption(optionType: .option2, title: "Take No Action", summary: "You cannot give in to the demands of a small group of extremists demanding that we ban a book. Before we know it there will be capitalists wanting to ban the works of Karl Marx. Freedom to express peoples views, even if those views are controversial is one of the basic freedoms of our society."))
    }
    
    override func setup(with global: GlobalSimulation) {

        self.add(simulation: RandomProperty(minimum: 0.0, maximum: 0.8))
        
        global.dilemmas.add(dilemma: self)
    }
    
    override func effectsOf(optionType: DilemmaOptionType, for global: GlobalSimulation?) -> [Effect] {
        if optionType == .option1 {
            // -13% Liberal relations
            let effectOnLiberals = Effect(name: "Blasphemy effect on Liberals", value: 1.0, decay: 0.8)
            global?.groups.liberals.mood.add(simulation: effectOnLiberals, formula: "-0.13*x")
            
            // +13% Religious relations
            let effectOnReligious = Effect(name: "Blasphemy effect on Religious", value: 1.0, decay: 0.8)
            global?.groups.religious.mood.add(simulation: effectOnReligious, formula: "0.13*x")
            
            let decayEffect = Effect(name: "Blasphemy decay", value: -1.0, decay: 0.9) //
            global?.dilemmas.blasphemyDilemma.add(simulation: decayEffect)
            
            return [effectOnLiberals, effectOnReligious, decayEffect]
        } else {
            // +10% Liberal relations
            let effectOnLiberals = Effect(name: "Blasphemy effect on Liberals", value: 1.0, decay: 0.8)
            global?.groups.liberals.mood.add(simulation: effectOnLiberals, formula: "0.1*x")
            
            // -21% Religious relations
            let effectOnReligious = Effect(name: "Blasphemy effect on Religious", value: 1.0, decay: 0.8)
            global?.groups.religious.mood.add(simulation: effectOnReligious, formula: "-0.21*x")
            
            let decayEffect = Effect(name: "Blasphemy decay", value: -1.0, decay: 0.9) //
            global?.dilemmas.blasphemyDilemma.add(simulation: decayEffect)
            
            return [effectOnLiberals, effectOnReligious, decayEffect]
        }
    }
}
