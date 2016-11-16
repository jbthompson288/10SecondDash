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
    
    init() {
        _ = load()
    }
    
    func create(with score: Double) -> HighScore {
        let highScore = HighScore(score: score)
        
        return highScore
    }
    
    func load() -> HighScore {
        let highScore = HighScore(score: UserDefaults.standard.double(forKey: kHighScore))
        
        return highScore
    }

    func checkScore(highScore: HighScore) {
//        if highScores.count == 3 {
//            for (index, eachScore) in highScores.enumerated() {
//                if highScore.score > eachScore.score {
//                    highScores.insert(highScore, at: index)
//                    highScores.remove(at: 3)
//                    return
//                }
//            }
//        } else {
//            highScores.append(highScore)
//        }
//    }
    }
    
    func save() {
        UserDefaults.standard.double(forKey: kHighScore)
    }
}
