//
//  ViewController.swift
//  CustomAnimations
//
//  Created by Midhet Sulemani Old on 10/8/19.
//  Copyright © 2019 DevFest. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var appButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        for eachButton in appButtons {
            eachButton.layer.cornerRadius = 5
            eachButton.clipsToBounds = true
        }
    }
}
