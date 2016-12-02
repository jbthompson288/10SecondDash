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
        self.swipe.direction = [.down, .up]
        view.addGestureRecognizer(self.swipe)
    }
    
    ///Amination of the avatar to move around the screen clockwise
    func handleSwipe() {
        moveAvatar(170)
    }
    
}
