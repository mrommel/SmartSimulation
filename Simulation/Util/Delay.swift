//
//  Delay.swift
//  Simulation
//
//  Created by Michael Rommel on 08.02.19.
//  Copyright © 2019 Michael Rommel. All rights reserved.
//

import Foundation

class Delay {
    
    static func delayed(by delay: Double, closure: @escaping () -> ()) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            closure()
        }
    }
}
