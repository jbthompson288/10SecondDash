//
//  AvatarViewController.swift
//  10SecondDash
//
//  Created by JB Thompson on 10/25/16.
//  Copyright © 2016 JB Thompson. All rights reserved.
//

import UIKit

class AvatarViewController: UIViewController, UIGestureRecognizerDelegate, UITextFieldDelegate {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var avatarView: UIView!
    @IBOutlet weak var dashLabel: UILabel!
    @IBOutlet weak var countdownLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreAndTryAgainLabel: UILabel!
    @IBOutlet weak var bestDashRunLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var bottomAvatarConstraint: NSLayoutConstraint!
    @IBOutlet weak var heightAvatarConstraint: NSLayoutConstraint!
    @IBOutlet weak var widthAvatarConstraint: NSLayoutConstraint!
    @IBOutlet weak var trailingAvatarConstraint: NSLayoutConstraint!
    
    
    // MARK: - Properties
    
    let avatarSize: CGFloat = 70.0
    var timeRemaining: TimeInterval?
    var scoreLabelText: Double = 0.00
    let pointsAdded: Double = 0.25
    var tap: UITapGestureRecognizer?
    var dashTimer = Timer()
    var dashCount = 4
    var countdownTimer = Timer()
    var countdownCount = 10
    var highScore = HighScoresController.shared.load()
    
    // MARK: - Tap Gesture Methods (Animation)
    
    ///Allows the full screen to be tapped to initiate the animation
    func addTapGestureRecognizer() {
        self.tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.tap?.delegate = self
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(self.tap!)
    }
    
    func removeTapGestureRecognizer() {
        self.view.removeGestureRecognizer(tap!)
    }
    
    ///Amination of the avatar to move around the screen clockwise
    func handleTap() {
        let travelDistance:CGFloat = 100
        let currentFrame = avatarView.frame
        let startingXPosition = avatarView.frame.origin.x
        let startingYPosition = avatarView.frame.origin.y
        let bottomLeftEndingXPosition = view.frame.origin.x
        let topLeftEndingYPosition = view.frame.origin.y
        let topRightEndingXPosition = view.frame.width - self.avatarSize
        let bottomRightEndingYPosition = view.frame.height - self.avatarSize
        
        //Movement from bottom right to bottom left
        
        if startingXPosition <= travelDistance && avatarView.frame.origin.y == view.frame.height - avatarView.frame.height {
            UIView.animate(withDuration: 0.1, animations: {
                self.avatarView.frame = CGRect(x: bottomLeftEndingXPosition, y: startingYPosition, width: self.avatarSize, height: self.avatarSize)
            })
        } else if startingXPosition > bottomLeftEndingXPosition && avatarView.frame.origin.y == view.frame.height - avatarView.frame.height {
            UIView.animate(withDuration: 0.1, animations: {
                self.avatarView.frame = CGRect(x: currentFrame.origin.x - travelDistance, y: startingYPosition, width: self.avatarSize, height: self.avatarSize)
            })
        }
        
        //Scoring for bottom left corner
        // TODO: write code for picture to rotate
        
        if startingYPosition > topLeftEndingYPosition && avatarView.frame.origin.x == bottomLeftEndingXPosition && startingXPosition <= travelDistance && avatarView.frame.origin.y == view.frame.height - avatarView.frame.height {
            self.scoreLabelText += self.pointsAdded
            self.scoreLabel.text = String(self.scoreLabelText)
        }
        
        //Movement from bottom left to top left
        
        if startingYPosition <= travelDistance && avatarView.frame.origin.x == bottomLeftEndingXPosition {
            UIView.animate(withDuration: 0.1, animations: {
                self.avatarView.frame = CGRect(x: bottomLeftEndingXPosition, y: topLeftEndingYPosition, width: self.avatarSize, height: self.avatarSize)
            })
        } else if startingYPosition > topLeftEndingYPosition && avatarView.frame.origin.x == bottomLeftEndingXPosition {
            UIView.animate(withDuration: 0.1, animations: {
                self.avatarView.frame = CGRect(x: bottomLeftEndingXPosition, y: currentFrame.origin.y - travelDistance, width: self.avatarSize, height: self.avatarSize)
            })
        }
        
        //Scoring for top left corner  (NEED TO HAVE PICTURE ROTATE AS WELL????)
        
        if startingXPosition < topRightEndingXPosition && avatarView.frame.origin.y == topLeftEndingYPosition && startingYPosition <= travelDistance && avatarView.frame.origin.x == bottomLeftEndingXPosition {
            self.scoreLabelText += self.pointsAdded
            self.scoreLabel.text = String(self.scoreLabelText)
        }
        
        //Movement from top left to top right
        
        if startingXPosition >= topRightEndingXPosition - travelDistance && avatarView.frame.origin.y == bottomLeftEndingXPosition {
            UIView.animate(withDuration: 0.1, animations: {
                self.avatarView.frame = CGRect(x: topRightEndingXPosition, y: topLeftEndingYPosition, width: self.avatarSize, height: self.avatarSize)
            })
        } else if startingXPosition < topRightEndingXPosition && avatarView.frame.origin.y == topLeftEndingYPosition {
            UIView.animate(withDuration: 0.1, animations: {
                self.avatarView.frame = CGRect(x: currentFrame.origin.x + travelDistance, y: topLeftEndingYPosition, width: self.avatarSize, height: self.avatarSize)
            })
        }
        
        //Scoring for top right corner
        // TODO: write code for picture to rotate
        
        if startingYPosition < bottomRightEndingYPosition && avatarView.frame.origin.x == topRightEndingXPosition && startingXPosition >= topRightEndingXPosition - travelDistance && avatarView.frame.origin.y == bottomLeftEndingXPosition {
            self.scoreLabelText += self.pointsAdded
            self.scoreLabel.text = String(self.scoreLabelText)
        }
        
        //Movement from top right to bottom right
        
        if startingYPosition >= bottomRightEndingYPosition - travelDistance && avatarView.frame.origin.x == topRightEndingXPosition {
            UIView.animate(withDuration: 0.1, animations: {
                self.avatarView.frame = CGRect(x: topRightEndingXPosition, y: bottomRightEndingYPosition, width: self.avatarSize, height: self.avatarSize)
            }, completion: {(value: Bool) in
                self.scoreLabelText += self.pointsAdded
                self.scoreLabel.text = String(self.scoreLabelText)
                // TODO: ADD IMAGE ROTATION CODE HERE
                
            })
        } else if startingYPosition < bottomRightEndingYPosition && avatarView.frame.origin.x == topRightEndingXPosition {
            UIView.animate(withDuration: 0.1, animations: {
                self.avatarView.frame = CGRect(x: topRightEndingXPosition, y: currentFrame.origin.y + travelDistance, width: self.avatarSize, height: self.avatarSize)
            })
        }
    }
    
    // MARK: - Dash Countdown Methods
    
    func dashStartCountdown() {
        dashTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(dashUpdate), userInfo: nil, repeats: true)
    }
    
    func dashUpdate() {
        if (dashCount > 1) {
            dashCount -= 1
            dashLabel.text = "\(dashCount)"
        } else {
            dashTimer.invalidate()
            dashLabel.text = "DASH!"
            avatarView.removeConstraints([bottomAvatarConstraint, trailingAvatarConstraint])
            countdownStartCountdown()
            addTapGestureRecognizer()
        }
    }
    
    // MARK: - Timer Countdown Methods
    
    func countdownStartCountdown(){
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countdownUpdate), userInfo: nil, repeats: true)
    }
    
    func countdownUpdate() {
        if (countdownCount > 1) {
            countdownCount -= 1
            countdownLabel.text = "\(countdownCount)"
        } else {
            countdownTimer.invalidate()
            countdownLabel.text = "DONE!"
            self.removeTapGestureRecognizer()
            self.highScoreResult()
        }
    }
    
    ///Checks if the current high score is greater than previous high score
    func highScoreResult() {
        if self.scoreLabelText > self.highScore.score {
            _ = HighScoresController.shared.create(with: self.scoreLabelText)
            HighScoresController.shared.save()
            self.highScoreAndTryAgainLabel.isHidden = false
            self.highScoreAndTryAgainLabel.text = "NEW HIGH SCORE!"
        } else {
            self.highScoreAndTryAgainLabel.isHidden = false
            self.highScoreAndTryAgainLabel.text = "TRY AGAIN"
            self.bestDashRunLabel.isHidden = false
            self.highScoreLabel.isHidden = false
            self.highScoreLabel.text = String(self.highScore.score)
        }
    }
    
    // MARK: - Life Cycle Methods
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        dashStartCountdown()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.highScoreAndTryAgainLabel.isHidden = true
        self.bestDashRunLabel.isHidden = true
        self.highScoreLabel.isHidden = true
    }
}
