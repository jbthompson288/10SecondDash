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
    @IBOutlet weak var dashLabel: UILabel!
    @IBOutlet weak var countdownLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var enterInitialsLabel: UILabel!
    @IBOutlet weak var initialsTextField: UITextField!
    
    let avatarSize: CGFloat = 70.0
    
    // MARK: - Dash Countdown Methods
    
    var timer = Timer()
    var count = 4
    
    func startCountdown(){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(update), userInfo: nil, repeats: true)
    }
    
    func update() {
        if (count > 1) {
            count -= 1
            dashLabel.text = "\(count)"
        } else {
            timer.invalidate()
            dashLabel.text = "DASH!"
            animate()
        }
    }
    
    // MARK: - Animations Method
    
    func animate() {
        let aroundScreen = CAKeyframeAnimation()
        
        aroundScreen.keyPath = "position"
        aroundScreen.path = CGPath(rect: CGRect(x: self.avatarSize / 2, y: self.avatarSize / 2, width: self.view.frame.width - self.avatarSize, height: self.view.frame.height - self.avatarSize), transform: nil)
        aroundScreen.duration = 4
        aroundScreen.repeatCount = Float.infinity
        aroundScreen.calculationMode = kCAAnimationPaced
        aroundScreen.rotationMode = kCAAnimationRotateAuto
        
        self.avatarView.layer.add(aroundScreen, forKey: "around")
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
            
        startCountdown()
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
