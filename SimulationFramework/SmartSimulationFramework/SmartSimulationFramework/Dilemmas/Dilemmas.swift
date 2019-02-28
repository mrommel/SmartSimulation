//
//  Dilemmas.swift
//  SmartSimulationFramework
//
//  Created by Michael Rommel on 26.02.19.
//  Copyright © 2019 Michael Rommel. All rights reserved.
//

import Foundation

public class Dilemmas {
    
    public var blasphemyDilemma: Blasphemy
    
    fileprivate var dilemmas: [Dilemma] = []
    
    init() {
        self.blasphemyDilemma = Blasphemy()
    }

    func setup(with global: GlobalSimulation) {
        
        self.blasphemyDilemma.setup(with: global)
    }
    
    func add(dilemma: Dilemma) {
        
        self.dilemmas.append(dilemma)
    }
    
    func calculate() {
        
        self.dilemmas.forEach { $0.calculate() }
    }
    
    func push() {
        
        self.dilemmas.forEach { $0.push() }
    }
    
    func findBestDilemma(with global: GlobalSimulation) -> Dilemma? {
        
        let maxScore = self.dilemmas.max(by: { $0.value() < $1.value() })?.value() ?? 0
        let allDilemmasWithMaxScore = self.dilemmas.filter { $0.value() == maxScore }
        //print("Best score: \(maxScore) => \(allEventsWithMaxScore.count) items")
        
        if !allDilemmasWithMaxScore.isEmpty {
            
            let dilemmaThatTriggered = allDilemmasWithMaxScore.randomItem()

            return dilemmaThatTriggered
        }
        
        return nil
    }
}
