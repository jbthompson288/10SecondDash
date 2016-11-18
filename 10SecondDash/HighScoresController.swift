//
//  HighScoreController.swift
//  10SecondDash
//
//  Created by JB Thompson on 11/12/16.
//  Copyright © 2016 JB Thompson. All rights reserved.
//

import Foundation

class HighScoresController {
    
    private let kHighScore = "highScore"
    static let shared = HighScoresController()
    
    var highScore = HighScore()
    
//    init() {
//        _ = load()
//    }
    
    func create(with score: Double) -> HighScore {
        self.highScore = HighScore(score: score)
        
        return highScore
    }
    
    func load() -> HighScore {
        self.highScore = HighScore(score: UserDefaults.standard.double(forKey: kHighScore))
        
        return highScore
    }
    
    func save() {
        UserDefaults.standard.set(highScore.score, forKey: kHighScore)
        UserDefaults.standard.synchronize()
    }
}
