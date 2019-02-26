//
//  SwiftLogExtension.swift
//  Simulation
//
//  Created by Michael Rommel on 25.02.19.
//  Copyright © 2019 Michael Rommel. All rights reserved.
//

import Foundation
import SwiftLog

extension Log {
    
    // TODO: check if files are in correct order
    func readAll() -> String {

        var content: String = ""
        do {
            let files = try FileManager.default.contentsOfDirectory(atPath: self.directory)
            for fileName in files {
                let path = "\(self.directory)/\(fileName)"
                if FileManager.default.isReadableFile(atPath: path) {
                    content = "\(content)\n\(try String(contentsOfFile: path))"
                }
            }
        } catch {
            // does nothing, because the file might not be there
        }
        
        return content
    }
}
