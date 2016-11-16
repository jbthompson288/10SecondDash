//
//  HighScoreController.swift
//  10SecondDash
//
//  Created by JB Thompson on 11/12/16.
//  Copyright © 2016 JB Thompson. All rights reserved.
//

import Foundation

class HighScoresController {
    
    private let kHighScores = "highScores"
    
    static let shared = HighScoresController()
    
    init() {
        self.highScores = load()
    }
    
    
    var highScores = [HighScore]() {
        didSet {
            save()
            highScores.sort(by: { $0.score > $1.score })
        }
    }
    
    func create(with name: String, score: Double) {
        let highScore = HighScore(name: name, score: score)
        if highScores.count >= 3 {
        }
        highScores.append(highScore)
    }
    
    func checkScore(highScore: HighScore) {
        if highScores.count == 3 {
            for (index, eachScore) in highScores.enumerated() {
                if highScore.score > eachScore.score {
                    highScores.insert(highScore, at: index)
                    highScores.remove(at: 3)
                    return
                }
            }
        } else {
            highScores.append(highScore)
        }
    }
    
    func save() {
        let highScoreDictionaries = highScores.map { $0.dictionaryCopy }
        //UserDefaults.standard.set(highScoreDictionaries, forKey: kHighScores)
    }
    
    func load() -> [HighScore] {
        guard let highScoreDictionaries = UserDefaults.standard.array(forKey: kHighScores) as? [[String: Any]] else { return [] }
        
        let highScores = highScoreDictionaries.flatMap { HighScore.init (dictionary: $0) }
        
        return highScores
    }
}
