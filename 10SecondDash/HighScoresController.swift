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
    
    ///Creates an instance of HighScore
    func create(with score: Double) -> HighScore {
        self.highScore = HighScore(score: score)
        return highScore
    }
    
    ///Loads the HighScore instance stored in UserDefaults
    func load() -> HighScore {
        self.highScore = HighScore(score: UserDefaults.standard.double(forKey: kHighScore))
        return highScore
    }
    
    ///Saves the instance of HighScore to UserDefaults
    func save() {
        UserDefaults.standard.set(highScore.score, forKey: kHighScore)
        UserDefaults.standard.synchronize()
    }
}
