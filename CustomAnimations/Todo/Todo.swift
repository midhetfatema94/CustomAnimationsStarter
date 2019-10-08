//
//  Todo.swift
//  CustomAnimations
//
//  Created by Midhet Sulemani on 10/3/19.
//  Copyright © 2019 DevFest. All rights reserved.
//

import UIKit

class Todo: UIView {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet var taskStack: [UILabel]!
    @IBOutlet var checkers: [UIButton]!
    
    @IBAction func checkingBox(_ sender: UIButton) {
        UIView.animate(withDuration: 0.2, animations: {
            sender.alpha = 0
        }, completion: {_ in
            UIView.animate(withDuration: 0.2, animations: {
                sender.isSelected = !sender.isSelected
                sender.alpha = 1
            })
        })
    }
    
    public override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        loadViewFromNib()
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        loadViewFromNib()
    }
    
    func addTasks(taskArray: [String]) {
        for (i, eachTask) in taskStack.enumerated() {
            eachTask.text = taskArray[i]
        }
    }
    
    private func loadViewFromNib() {
        let bundle = Bundle.init(for: self.classForCoder)
        bundle.loadNibNamed("Todo", owner: self, options: nil)
        addSubview(mainView)
        mainView.frame = self.bounds
        mainView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        for check in checkers {
            check.setImage(UIImage(imageLiteralResourceName: "checkbox_fill"), for: .selected)
            check.setImage(UIImage(imageLiteralResourceName: "checkbox_empty"), for: .normal)
        }
    }
}
