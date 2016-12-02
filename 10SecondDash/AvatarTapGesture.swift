//
//  AvatarTapGesture.swift
//  10SecondDash
//
//  Created by JB Thompson on 11/24/16.
//  Copyright © 2016 JB Thompson. All rights reserved.
//


import Foundation
import UIKit

extension AvatarViewController {
    
    func addAvatarTapGestureRecognizer() {
        self.avatarTap = UITapGestureRecognizer(target: self, action: #selector(handleAvatarTap))
        self.avatarView.isUserInteractionEnabled = true
        self.avatarView.addGestureRecognizer(self.avatarTap)
    }
    
//    func removeAvatarTapGestureRecognizer() {
//        self.avatarView.removeGestureRecognizer(avatarTap!)
//    }
    
    ///Amination of the avatar to move around the screen clockwise
    func handleAvatarTap() {
        moveAvatar(300)
    }
    
}

 
 
 
