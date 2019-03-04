//
//  Voter.swift
//  SmartSimulationFramework
//
//  Created by Michael Rommel on 28.02.19.
//  Copyright © 2019 Michael Rommel. All rights reserved.
//

import Foundation

public class Voter {
    
    let name: String
    var groups: [Group] = []
    
    public init(name: String) {
        self.name = name
    }
    
    public func addMembership(to group: Group) {
        self.groups.append(group)
    }
    
    public func mood() -> Double {
        
        guard !self.groups.isEmpty else {
            return 0.7 // 70% mood, if in no groups
        }
        
        var mood = 0.0
        
        for group in self.groups {
            let groupMood = group.mood.value()
            mood += groupMood > 0.0 ? groupMood : 0.0
        }
        
        return mood / Double(self.groups.count)
    }
}

extension Voter: CustomDebugStringConvertible {
    
    public var debugDescription: String {
        return "Voter(name: \(self.name) - \(self.groups))"
    }
}

public class Voters {
    
    var groups: Groups?
    
    init() {
        
    }
    
    func setup(with global: GlobalSimulation) {
        self.groups = global.groups
    }
    
    private func generateVoter(named name: String) -> Voter {
        
        let voter = Voter(name: name)
        var groupList: [Group] = []
        
        if let groups = self.groups {
            for group in groups {
                groupList.append(group)
            }
        }
        
        groupList.shuffle()
        
        for group in groupList {
            
            // modify frequency based on voters existing groups
            let frequency = group.influencedFrequency(by: voter.groups)
            
            // evaluate if voter is part of group
            let rnd = Double.random
            if rnd <= frequency {
                voter.addMembership(to: group)
            }
        }
        
        return voter
    }
    
    public func generateVoters() -> [Voter] {
        
        // 20 names
        /*let names = ["Achilles", "Alexander", "Penelope", "Helena", "Gaia",
                     "Leonidas", "Thalia", "Andreas", "Selene", "Damian",
                     "Phaedra", "Jason", "Nephele", "Socrates", "alpha",
                     "beta", "gamma", "delta", "zeta", "omega"]*/
        var names: [String] = []
        for i in 0..<100 {
            names.append("Voter\(i)")
        }
        
        return names.map { self.generateVoter(named: $0) }
    }
    
    public func generalMoodValue() -> Double {
        
        let voters = self.generateVoters()
        
        guard !voters.isEmpty else {
            return 0.7
        }
        
        var mood = 0.0
        
        for voter in voters {
            mood += voter.mood()
        }
        
        return mood / Double(voters.count)
    }
    
    public func generalMoodValueText() -> String {
        
        return self.generalMoodValue().format(with: ".2")
    }
}
