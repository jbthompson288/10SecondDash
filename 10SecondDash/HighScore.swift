//
//  HighScore.swift
//  10SecondDash
//
//  Created by JB Thompson on 11/12/16.
//  Copyright © 2016 JB Thompson. All rights reserved.
//

import Foundation

struct HighScore {
    
    let name: String
    let score: Int
    
    init(name: String, score: Int) {
        self.name = name
        self.score = score
    }
    
    /// allow to save into UserDefaults
    var dictionaryCopy: [String: Any] {
        return [kName: name, kScore: score]
    }
    
    
    
    /// allow us to take a dictornary that was stored in UserDefaults and turn that dictionary into a HighScore object
    init?(dictionary: [String: Any]) {
        guard let name = dictionary[kName] as? String,
            let score = dictionary[kScore] as? Int else { return nil }
        
        self.name = name
        self.score = score
    }
    
    private let kName = "name"
    private let kScore = "score"
    
}
