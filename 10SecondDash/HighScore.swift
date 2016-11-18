//
//  HighScore.swift
//  10SecondDash
//
//  Created by JB Thompson on 11/12/16.
//  Copyright © 2016 JB Thompson. All rights reserved.
//

import Foundation

struct HighScore {
    
    let score: Double
    
    init() {
        self.score = 0.00
    }
    
    init(score: Double) {
        self.score = score
    }
}
