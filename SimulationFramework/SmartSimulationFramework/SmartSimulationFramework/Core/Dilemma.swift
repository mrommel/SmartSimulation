//
//  Dilemma.swift
//  SmartSimulationFramework
//
//  Created by Michael Rommel on 26.02.19.
//  Copyright © 2019 Michael Rommel. All rights reserved.
//

import UIKit

public protocol DilemmaDelegate: class {
    func triggered(dilemma: Dilemma?)
}

public enum DilemmaOptionType {
    case option1
    case option2
}

public struct DilemmaOption {
    
    public let optionType: DilemmaOptionType
    public let title: String
    public let summary: String
}

public class Dilemma: Simulation {
    
    weak var delegate: DilemmaDelegate?
    public var firstOption: DilemmaOption
    public var secondOption: DilemmaOption
    
    init(image: UIImage?, name: String, summary: String, category: Category, firstOption: DilemmaOption, secondOption: DilemmaOption) {
        
        guard firstOption.optionType == .option1 else {
            fatalError("wrong option type of firstOption: \(firstOption)")
        }
        
        guard secondOption.optionType == .option2 else {
            fatalError("wrong option type of secondOption: \(secondOption)")
        }
        
        self.firstOption = firstOption
        self.secondOption = secondOption
        
        super.init(
            image: image,
            name: name,
            summary: summary,
            category: category,
            value: 0.0)
    }
    
    func effectsOf(optionType: DilemmaOptionType, for global: GlobalSimulation?) -> [Effect] {
        
        assertionFailure("Subclasses need to implement this method")
        
        return []
    }
}
