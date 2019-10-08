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
    
    
    override func viewDidAppear(_ animated: Bool) {
        countdownView = CountdownProgressBar(frame: countdownProgressBar.bounds)
        countdownProgressBar.addSubview(countdownView)
        countdownView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
    @objc func handleTap() {
        countdownView.startCoundown(duration: 20, showPulse: true, showMS: true)
    }
}

extension GradientViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}



