//
//  AvatarViewController.swift
//  10SecondDash
//
//  Created by JB Thompson on 10/25/16.
//  Copyright © 2016 JB Thompson. All rights reserved.
//

import UIKit

class AvatarViewController: UIViewController, UIGestureRecognizerDelegate {
    
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
    
    
    // MARK: - Tap Gesture Methods
    
    func addTapGestureRecognizer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tap.delegate = self
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(tap)
    }
    
    func handleTap() {
        let currentFrame = avatarView.frame
        let startingXPosition = avatarView.frame.origin.x
        let startingYPosition = avatarView.frame.origin.y
        let leftEndingXPosition = (startingXPosition - view.frame.width) + currentFrame.width
        
        if avatarView.center.x >= avatarSize / 2 && avatarView.frame.origin.y == view.frame.height - avatarView.frame.height {
            UIView.animate(withDuration: 0.5, animations: {
                self.avatarView.frame = CGRect(x: currentFrame.origin.x - 20, y: startingYPosition, width: self.avatarSize, height: self.avatarSize)
            })
            
            
            
        }
        // BL->TL: if y center is <= avatarSize / 2 and x is == view.frame.width - avatar width
            //move 20 points up
        // TL->TR: if x center is >= view.frame.width - avatarSize / 2 and y is == 0
            //mov
        
        
        
        
        
        
        
        
//        moveToBottomLeftAnimation()
    }
    
    
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
            addTapGestureRecognizer()
            
        }
    }
    
    // MARK: - Animations Methods
    
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
        self.highScoreLabel.isHidden = true
        self.enterInitialsLabel.isHidden = true
        self.initialsTextField.isHidden = true
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
