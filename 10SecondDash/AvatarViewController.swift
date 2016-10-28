//
//  AvatarViewController.swift
//  10SecondDash
//
//  Created by JB Thompson on 10/25/16.
//  Copyright © 2016 JB Thompson. All rights reserved.
//

import UIKit

class AvatarViewController: UIViewController {
    
    @IBOutlet weak var avatarView: UIView!
    
    let avatarSize: CGFloat = 70.0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // MARK: - Animations
        let aroundScreen = CAKeyframeAnimation()
        
        aroundScreen.keyPath = "position"
        aroundScreen.path = CGPath(rect: CGRect(x: avatarSize / 2, y: avatarSize / 2, width: view.frame.width - avatarSize, height: view.frame.height - avatarSize), transform: nil)
        aroundScreen.duration = 4
        aroundScreen.repeatCount = Float.infinity
        aroundScreen.calculationMode = kCAAnimationPaced
        aroundScreen.rotationMode = kCAAnimationRotateAuto
        
        self.avatarView.layer.add(aroundScreen, forKey: "around")
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
