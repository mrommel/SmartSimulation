//
//  ViewModelType.swift
//  simulation
//
//  Created by Michael Rommel on 08.02.19.
//  Copyright © 2019 Michael Rommel. All rights reserved.
//

import Foundation

protocol ViewModelType {
    func bootstrap()
    var delegate: ViewModelDelegate? { get set }
}
