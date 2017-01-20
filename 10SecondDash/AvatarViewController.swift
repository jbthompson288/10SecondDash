//
//  AvatarViewController.swift
//  10SecondDash
//
//  Created by JB Thompson on 10/25/16.
//  Copyright © 2016 JB Thompson. All rights reserved.
//

import UIKit

class AvatarViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var avatarView: UIImageView!
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
    @IBOutlet weak var mainMenuButton: UIButton!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet var tap: UITapGestureRecognizer!
    @IBOutlet var swipeDownAndUp: UISwipeGestureRecognizer!
    @IBOutlet var avatarTap: UITapGestureRecognizer!
    @IBOutlet var swipeLeftAndRight: UISwipeGestureRecognizer!
    @IBOutlet weak var plus5Label: UILabel!
    @IBOutlet weak var tapScreenLabel: UILabel!
    @IBOutlet weak var swipeScreenLabel: UILabel!
    @IBOutlet weak var tapRunnerLabel: UILabel!
    
    // MARK: - Properties
    
    let avatarSize: CGFloat = 70.0
    var timeRemaining: TimeInterval?
    var scoreLabelText: Double = 0.00
    let pointsAdded: Double = 0.25
    var dashTimer = Timer()
    var dashCount = 4
    var countdownTimer = Timer()
    var countdownCount: Double = 10
    var highScore = HighScoresController.shared.load()
    
    
    ///Amination of the avatar to move around the screen clockwise
    func moveAvatar(_ travelDistance: CGFloat) {
        let currentFrame = avatarView.frame
        let startingXPosition = avatarView.frame.origin.x
        let startingYPosition = avatarView.frame.origin.y
        let bottomLeftEndingXPosition = view.frame.origin.x
        let topLeftEndingYPosition = view.frame.origin.y
        let topRightEndingXPosition = view.frame.width - self.avatarSize
        let bottomRightEndingYPosition = view.frame.height - self.avatarSize
        
        //Movement from bottom right to bottom left
        
        if startingXPosition <= travelDistance && startingYPosition == view.frame.height - avatarView.frame.height {
            imageSelection()
            UIView.animate(withDuration: 0.1, animations: {
                self.avatarView.frame = CGRect(x: bottomLeftEndingXPosition, y: startingYPosition, width: self.avatarSize, height: self.avatarSize)
            })
        } else if startingXPosition > bottomLeftEndingXPosition && startingYPosition == view.frame.height - avatarView.frame.height {
            imageSelection()
            UIView.animate(withDuration: 0.1, animations: {
                self.avatarView.frame = CGRect(x: currentFrame.origin.x - travelDistance, y: startingYPosition, width: self.avatarSize, height: self.avatarSize)
            })
        }
        
        //Scoring for bottom left corner
        
        if startingYPosition > topLeftEndingYPosition && startingXPosition == bottomLeftEndingXPosition && startingXPosition <= travelDistance && startingYPosition == view.frame.height - avatarView.frame.height {
            imageSelection()
            bottomLeftImageRotation()
            self.scoreLabelText += self.pointsAdded
            self.scoreLabel.text = String(self.scoreLabelText)
        }
        
        //Movement from bottom left to top left
        
        if startingYPosition <= travelDistance && Int(startingXPosition) == Int(bottomLeftEndingXPosition) {
            imageSelection()
            UIView.animate(withDuration: 0.1, animations: {
                self.avatarView.frame = CGRect(x: bottomLeftEndingXPosition, y: topLeftEndingYPosition, width: self.avatarSize, height: self.avatarSize)
            })
        } else if startingYPosition > topLeftEndingYPosition && currentFrame.origin.x == bottomLeftEndingXPosition {
            imageSelection()
            UIView.animate(withDuration: 0.1, animations: {
                self.avatarView.frame = CGRect(x: bottomLeftEndingXPosition, y: currentFrame.origin.y - travelDistance, width: self.avatarSize, height: self.avatarSize)
            })
        }
        
        //Scoring for top left corner
        
        if startingXPosition < topRightEndingXPosition && currentFrame.origin.y == topLeftEndingYPosition && startingYPosition <= travelDistance && avatarView.frame.origin.x == bottomLeftEndingXPosition {
            imageSelection()
            topLeftImageRotation()
            self.scoreLabelText += self.pointsAdded
            self.scoreLabel.text = String(self.scoreLabelText)
        }
        
        //Movement from top left to top right
        
        if startingXPosition >= topRightEndingXPosition - travelDistance && Int(startingYPosition) == Int(bottomLeftEndingXPosition) {
            imageSelection()
            UIView.animate(withDuration: 0.1, animations: {
                self.avatarView.frame = CGRect(x: topRightEndingXPosition, y: topLeftEndingYPosition, width: self.avatarSize, height: self.avatarSize)
            })
        } else if startingXPosition < topRightEndingXPosition && Int(startingYPosition) == Int(topLeftEndingYPosition) {
            imageSelection()
            UIView.animate(withDuration: 0.1, animations: {
                self.avatarView.frame = CGRect(x: currentFrame.origin.x + travelDistance, y: topLeftEndingYPosition, width: self.avatarSize, height: self.avatarSize)
            })
        }
        
        //Scoring for top right corner
        
        if Int(startingYPosition) < Int(bottomRightEndingYPosition) && avatarView.frame.origin.x == topRightEndingXPosition && startingXPosition >= topRightEndingXPosition - travelDistance && Int(avatarView.frame.origin.y) == Int(bottomLeftEndingXPosition) {
            imageSelection()
            topRightImageRotation()
            self.scoreLabelText += self.pointsAdded
            self.scoreLabel.text = String(self.scoreLabelText)
        }
        
        //Movement from top right to bottom right
        
        if startingYPosition >= bottomRightEndingYPosition - travelDistance && avatarView.frame.origin.x == topRightEndingXPosition {
            imageSelection()
            UIView.animate(withDuration: 0.1, animations: {
                self.avatarView.frame = CGRect(x: topRightEndingXPosition, y: bottomRightEndingYPosition, width: self.avatarSize, height: self.avatarSize)
            }, completion: {(value: Bool) in
                self.scoreLabelText += self.pointsAdded
                self.scoreLabel.text = String(self.scoreLabelText)
                self.bottomRightImageRotation()
                self.addTime()
            })
        } else if startingYPosition < bottomRightEndingYPosition && avatarView.frame.origin.x == topRightEndingXPosition {
            imageSelection()
            UIView.animate(withDuration: 0.1, animations: {
                self.avatarView.frame = CGRect(x: topRightEndingXPosition, y: currentFrame.origin.y + travelDistance, width: self.avatarSize, height: self.avatarSize)
            })
        }
    }
    
    func enableGestures() {
        self.tap.isEnabled = true
        self.avatarTap.isEnabled = true
        self.swipeDownAndUp.isEnabled = true
        self.swipeLeftAndRight.isEnabled = true
    }
    
    func disableGestures() {
        self.tap.isEnabled = false
        self.avatarTap.isEnabled = false
        self.swipeDownAndUp.isEnabled = false
        self.swipeLeftAndRight.isEnabled = false
    }
    
    @IBAction func handleTap() {
        if countdownCount < 0.1 {
            self.disableGestures()
        } else {
            self.enableGestures()
        moveAvatar(70)
        }
    }
    
    @IBAction func handleSwipe() {
        if countdownCount < 0.1 {
            self.disableGestures()
        } else {
            self.enableGestures()
            moveAvatar(170)
        }
    }
    
    @IBAction func handleAvatarTap() {
        if countdownCount < 0.1 {
            self.disableGestures()
        } else {
            moveAvatar(300)
        }
    }
    
    // MARK: - Image Selection Method
    
    func imageSelection() {
        if avatarView.image == #imageLiteral(resourceName: "start") {
            avatarView.image = #imageLiteral(resourceName: "up")
            return
        }
        if avatarView.image == #imageLiteral(resourceName: "up") {
            avatarView.image = #imageLiteral(resourceName: "up2")
            return
        }
        if avatarView.image == #imageLiteral(resourceName: "up2") {
            avatarView.image = #imageLiteral(resourceName: "up3")
            return
        }
        if avatarView.image == #imageLiteral(resourceName: "up3") {
            avatarView.image = #imageLiteral(resourceName: "run1")
            return
        }
        if avatarView.image == #imageLiteral(resourceName: "run1") {
            avatarView.image = #imageLiteral(resourceName: "run2")
            return
        }
        if avatarView.image == #imageLiteral(resourceName: "run2") {
            avatarView.image = #imageLiteral(resourceName: "run3")
            return
        }
        if avatarView.image == #imageLiteral(resourceName: "run3") {
            avatarView.image = #imageLiteral(resourceName: "run4")
            return
        }
        if avatarView.image == #imageLiteral(resourceName: "run4") {
            avatarView.image = #imageLiteral(resourceName: "run1")
            return
        }
    }
    
    // MARK: - Image Rotation Methods
    
    func bottomLeftImageRotation() {
        UIView.animate(withDuration: 0.1, animations: {
            self.avatarView.transform = CGAffineTransform(rotationAngle: (180 * CGFloat(M_PI)) / 360)
        })
    }
    func topLeftImageRotation() {
        UIView.animate(withDuration: 0.1, animations: {
            self.avatarView.transform = CGAffineTransform(rotationAngle: (360 * CGFloat(M_PI)) / 360)
        })
    }
    func topRightImageRotation() {
        UIView.animate(withDuration: 0.1, animations: {
            self.avatarView.transform = CGAffineTransform(rotationAngle: (540 * CGFloat(M_PI)) / 360)
        })
    }
    func bottomRightImageRotation() {
        UIView.animate(withDuration: 0.1, animations: {
            self.avatarView.transform = CGAffineTransform(rotationAngle: (720 * CGFloat(M_PI)) / 360)
        })
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
            self.enableGestures()
            tapScreenLabel.alpha = 0.0
            swipeScreenLabel.alpha = 0.0
            tapRunnerLabel.alpha = 0.0
        }
    }
    
    // MARK: - Timer Countdown Methods
    
    func countdownStartCountdown(){
        countdownTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(countdownUpdate), userInfo: nil, repeats: true)
    }
    
    func countdownUpdate() {
        if (countdownCount > 0.1) {
            countdownCount -= 0.1
            countdownLabel.text = "\(Int(ceil(countdownCount)))"
        } else {
            countdownTimer.invalidate()
            countdownLabel.text = "DONE!"
            self.disableGestures()
            self.highScoreResult()
            _ = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false, block: { (timer) in
                self.mainMenuButton.alpha = 1.0
            })
            self.dashLabel.alpha = 0.0
        }
    }
    
    func addTime() {
        if Int(scoreLabelText) % 4 == 0 {
            countdownCount += 5
            self.plus5Animation()
            countdownUpdate()
        }
    }
    
    func plus5Animation() {
        self.plus5Label.alpha = 1.0
        self.plus5Label.text = "+5"
        UIView.animate(withDuration: 1.0, animations: {
            self.plus5Label.alpha = 0.0
        })
    }
    
    ///Checks if the current high score is greater than previous high score
    func highScoreResult() {
        if self.scoreLabelText > self.highScore.score {
            _ = HighScoresController.shared.create(with: self.scoreLabelText)
            HighScoresController.shared.save()
            self.highScoreAndTryAgainLabel.alpha = 1.0
            self.highScoreAndTryAgainLabel.text = "NEW HIGH SCORE!"
        } else {
            self.highScoreAndTryAgainLabel.alpha = 1.0
            self.highScoreAndTryAgainLabel.text = "TRY AGAIN"
            self.bestDashRunLabel.alpha = 1.0
            self.highScoreLabel.alpha = 1.0
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
        self.highScoreAndTryAgainLabel.alpha = 0.0
        self.bestDashRunLabel.alpha = 0.0
        self.highScoreLabel.alpha = 0.0
        self.mainMenuButton.alpha = 0.0
        self.plus5Label.alpha = 0.0
        view.layoutIfNeeded()
        mainMenuButton.frame = CGRect(x: view.frame.width / 2.0 - mainMenuButton.frame.width / 2, y: view.frame.height - 120, width: mainMenuButton.frame.width, height: mainMenuButton.frame.height)
        stackView.frame = CGRect(x: view.frame.width / 2.0 - stackView.frame.width / 2, y: view.frame.height - 500, width: stackView.frame.width, height: stackView.frame.height)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tap.isEnabled = false
        self.swipeDownAndUp.isEnabled = false
        self.swipeDownAndUp.direction = [.down, .up]
        self.swipeLeftAndRight.isEnabled = false
        self.swipeLeftAndRight.direction = [.left, .right]
        self.avatarTap.isEnabled = false
    }
    
    
    
    
    
    
    
}
