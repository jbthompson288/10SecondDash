//
//  SwipeGesture.swift
//  10SecondDash
//
//  Created by JB Thompson on 11/24/16.
//  Copyright © 2016 JB Thompson. All rights reserved.
//

import Foundation
import UIKit

extension AvatarViewController {
    
    func addSwipeGestureRecognizer() {
        self.swipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        self.swipe?.delegate = self
        self.swipe?.direction = .down
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(self.swipe!)
    }
    
    func removeSwipeGestureRecognizer() {
        self.view.removeGestureRecognizer(swipe!)
    }
    
    ///Amination of the avatar to move around the screen clockwise
    func handleSwipe() {
        let travelDistance:CGFloat = 170
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
        
        if startingXPosition < topRightEndingXPosition && avatarView.frame.origin.y == topLeftEndingYPosition && startingYPosition <= travelDistance && avatarView.frame.origin.x == bottomLeftEndingXPosition {
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
                
            })
        } else if startingYPosition < bottomRightEndingYPosition && avatarView.frame.origin.x == topRightEndingXPosition {
            imageSelection()
            UIView.animate(withDuration: 0.1, animations: {
                self.avatarView.frame = CGRect(x: topRightEndingXPosition, y: currentFrame.origin.y + travelDistance, width: self.avatarSize, height: self.avatarSize)
            })
        }
    }
    
}
