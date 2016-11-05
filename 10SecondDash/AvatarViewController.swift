//
//  AvatarViewController.swift
//  10SecondDash
//
//  Created by JB Thompson on 10/25/16.
//  Copyright © 2016 JB Thompson. All rights reserved.
//

import UIKit

class AvatarViewController: UIViewController {
    
    @IBOutlet weak var testTapButton: UIButton!
    @IBOutlet weak var avatarView: UIView!
    @IBOutlet weak var dashLabel: UILabel!
    @IBOutlet weak var countdownLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var enterInitialsLabel: UILabel!
    @IBOutlet weak var initialsTextField: UITextField!
    
    @IBOutlet weak var bottomAvatarConstraint: NSLayoutConstraint!
    @IBOutlet weak var heightAvatarConstraint: NSLayoutConstraint!
    @IBOutlet weak var widthAvatarConstraint: NSLayoutConstraint!
    @IBOutlet weak var trailingAvatarConstraint: NSLayoutConstraint!
    
    let avatarSize: CGFloat = 70.0
    
    var timeRemaining: TimeInterval?
    
    var scoreLabelText: Double = 0.00
    let pointsAdded: Double = 0.25
    
    // MARK: - Dash Countdown Methods
    
    var dashTimer = Timer()
    var dashCount = 4
    
    func dashStartCountdown(){
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
//            animate()
            moveToBottomLeftAnimation()
        }
    }
    
    // MARK: - Animations Method
    
    func moveToBottomLeftAnimation() {
        let currentFrame = avatarView.frame
        let startingPosition = avatarView.frame.origin.x
        let endingPosition = (startingPosition - view.frame.width) + currentFrame.width
        UIView.animate(withDuration: 0.5, animations: {
            self.avatarView.frame = CGRect(x: endingPosition, y: currentFrame.origin.y, width: currentFrame.width, height: currentFrame.height)
        }, completion:  {(value: Bool) in
            self.scoreLabelText += self.pointsAdded
            self.scoreLabel.text = String(self.scoreLabelText)
            self.moveToTopLeftAnimation()
        })
    }
    
    func moveToTopLeftAnimation() {
        let currentFrame = avatarView.frame
        let startingPosition = avatarView.frame.origin.y
        let endingPosition = (startingPosition - view.frame.height) + currentFrame.height
        UIView.animate(withDuration: 0.5, animations: {
            self.avatarView.frame = CGRect(x: currentFrame.origin.x, y: endingPosition, width: currentFrame.width, height: currentFrame.height)
        }, completion: {(value: Bool) in
            self.scoreLabelText += self.pointsAdded
            self.scoreLabel.text = String(self.scoreLabelText)
            self.moveToTopRightAnimation()
        })
    }
    
    func moveToTopRightAnimation() {
        let currentFrame = avatarView.frame
        let startingPosition = avatarView.frame.origin.x
        let endingPosition = (startingPosition + view.frame.width) - currentFrame.width
        UIView.animate(withDuration: 0.5, animations: {
            self.avatarView.frame = CGRect(x: endingPosition, y: currentFrame.origin.y, width: currentFrame.width, height: currentFrame.height)
        }, completion: {(value: Bool) in
            self.scoreLabelText += self.pointsAdded
            self.scoreLabel.text = String(self.scoreLabelText)
            self.moveToBottomRightAnimation()
        })
    }
    
    func moveToBottomRightAnimation() {
        let currentFrame = avatarView.frame
        let startingPosition = avatarView.frame.origin.y
        let endingPosition = (startingPosition + view.frame.height) - currentFrame.height
        UIView.animate(withDuration: 0.5, animations: {
            self.avatarView.frame = CGRect(x: currentFrame.origin.x, y: endingPosition, width: currentFrame.width, height: currentFrame.height)
        }, completion: {(value: Bool) in
            self.scoreLabelText += self.pointsAdded
            self.scoreLabel.text = String(self.scoreLabelText)
            self.moveToBottomLeftAnimation()
        })
        
    }
    
//    func animate() {
//        
//        
//        
//        //Look into UIKit animation
//
//        let aroundScreen = CAKeyframeAnimation()
//        
//        aroundScreen.keyPath = "position"
//        aroundScreen.path = CGPath(rect: CGRect(x: self.avatarSize / 2, y: self.avatarSize / 2, width: self.view.frame.width - self.avatarSize, height: self.view.frame.height - self.avatarSize), transform: nil)
//        aroundScreen.duration = 4
//        aroundScreen.repeatCount = Float.infinity
//        aroundScreen.calculationMode = kCAAnimationPaced
//        aroundScreen.rotationMode = kCAAnimationRotateAuto
//        
//        
//        self.avatarView.layer.add(aroundScreen, forKey: "around")
//    }
    
    // MARK: - Timer Countdown Methods
    
    var countdownTimer = Timer()
    var countdownCount = 10
    
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
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
            
        dashStartCountdown()
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
