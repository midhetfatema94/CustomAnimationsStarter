//
//  GradientViewController.swift
//  CustomAnimations
//
//  Created by Midhet Sulemani on 10/3/19.
//  Copyright © 2019 DevFest. All rights reserved.
//

import UIKit

class GradientViewController: UIViewController {
    
    @IBOutlet weak var coundownTimerTF: UITextField!
    @IBOutlet weak var countdownProgressBar: UIView!
    
    // create outlet in the storyboard with type CountdownProgressBar
    var countdownView: CountdownProgressBar!
    
    @IBAction func showTimer(_ sender: UIButton) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        coundownTimerTF.delegate = self
    }
}

extension GradientViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}



