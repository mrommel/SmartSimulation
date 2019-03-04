//
//  Category.swift
//  SmartSimulationFramework
//
//  Created by Michael Rommel on 09.09.18.
//  Copyright © 2018 Michael Rommel. All rights reserved.
//

import Foundation

public enum Category: CaseIterable {
	case core

	case economy
	case welfare
	case foreign
	case lawOrder
	case publicServices
    case religion

	case effects
	case groups

	case `static`
    
    public var text: String {
    
        switch self {
        
        case .core:
            return "core"
        case .economy:
            return "economy"
        case .welfare:
            return "welfare"
        case .foreign:
            return "foreign"
        case .lawOrder:
            return "lawOrder"
        case .publicServices:
            return "publicServices"
        case .religion:
            return "religion"
        case .effects:
            return "effects"
        case .groups:
            return "groups"
        case .static:
            return "static"
        }
    }
}
