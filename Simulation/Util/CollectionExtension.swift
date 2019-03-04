//
//  CollectionExtension.swift
//  Simulation
//
//  Created by Michael Rommel on 04.03.19.
//  Copyright © 2019 Michael Rommel. All rights reserved.
//

import Foundation

extension Collection {
    func count(where test: (Element) throws -> Bool) rethrows -> Int {
        return try self.filter(test).count
    }
}
