//
//  MainMenuViewController.swift
//  10SecondDash
//
//  Created by JB Thompson on 10/25/16.
//  Copyright © 2016 JB Thompson. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        avatarImageView.startAnimating()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        avatarImageView.animationImages = [#imageLiteral(resourceName: "run1"), #imageLiteral(resourceName: "run2"), #imageLiteral(resourceName: "run3"), #imageLiteral(resourceName: "run4")]
        avatarImageView.animationDuration = 0.5
    }
}
