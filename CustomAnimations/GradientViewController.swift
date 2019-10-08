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
    @IBOutlet weak var milisecondBtn: UIButton!
    @IBOutlet weak var countdownProgressBar: UIView!
    
    // create outlet in the storyboard with type CountdownProgressBar
    var countdownView: CountdownProgressBar!
    
    @IBAction func showMiliseconds(_ sender: Any) {
        milisecondBtn.isSelected = !milisecondBtn.isSelected
    }
    
    @IBAction func showTimer(_ sender: UIButton) {
        countdownView.startCoundown(duration: Double(coundownTimerTF.text ?? ""), showPulse: false, showMS: milisecondBtn.isSelected)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        coundownTimerTF.delegate = self
        milisecondBtn.setImage(UIImage(imageLiteralResourceName: "checkbox_fill"), for: .selected)
        milisecondBtn.setImage(UIImage(imageLiteralResourceName: "checkbox_empty"), for: .normal)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        countdownView = CountdownProgressBar(frame: countdownProgressBar.bounds)
        countdownProgressBar.addSubview(countdownView)
        countdownView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
//        countdownView.startCoundown(duration: 20, showPulse: false)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        countdownProgressBar.startCoundown(duration: 20, showPulse: false)
    }
    
    
    
    @objc func handleTap() {
        countdownView.startCoundown(duration: 20, showPulse: true, showMS: true)
    }
}

extension GradientViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}



