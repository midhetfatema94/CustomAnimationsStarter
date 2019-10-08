//
//  TodoListViewController.swift
//  CustomAnimations
//
//  Created by Midhet Sulemani on 10/2/19.
//  Copyright © 2019 DevFest. All rights reserved.
//

import UIKit

class TodoListViewController: UIViewController {
    
    var welcomeLabel: UILabel!
    var nameLabel: UILabel!
    var underlineLabel: UIView!
    var labelTimer: Timer!
    
    var colorArray = [UIColor.red, UIColor.blue, UIColor.green]
    var initialLoad = true
    
    let categoryArr = ["Daily Tasks", "Groceries", "Deadlines"]
    let todoDailyArr = ["Cleaning", "Cooking", "Bathing"]
    let todoGroceriesArr = ["Rice", "Mutton", "Spices"]
    let todoWorkArr = ["Work Update", "Emails", "Jira"]
    
    @IBOutlet weak var pagingScroll: UIScrollView!
    @IBOutlet var todoCategory: [UIButton]!
    @IBOutlet weak var categoryStack: UIStackView!
    @IBOutlet weak var addNewTodoBtn: UIButton!
    
    @IBAction func selectTodo(_ sender: UIButton) {
        let contentOffsetPoint = sender.tag * Int(self.view.frame.width)
        self.pagingScroll.setContentOffset(CGPoint(x: contentOffsetPoint, y: 0), animated: false)
        underlineLabel.center.x = sender.center.x
    }
    
    @IBAction func addNewTodo(_ sender: UIButton) {
        
        let newTodoPage = UIViewController()
        self.navigationController?.pushViewController(newTodoPage, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelNamesAnimation(name: nil)
        
        pagingScroll.delegate = self
        pagingScroll.isPagingEnabled = true
        pagingScroll.contentSize = CGSize(width: UIScreen.main.bounds.width * CGFloat(todoCategory.count), height: pagingScroll.bounds.height)
        
        let todoDaily = Todo(frame: pagingScroll.bounds)
        todoDaily.addTasks(taskArray: todoDailyArr)
        pagingScroll.addSubview(todoDaily)
        
        let todoGroceries = Todo(frame: pagingScroll.bounds)
        todoGroceries.frame.origin.x += UIScreen.main.bounds.width
        todoGroceries.addTasks(taskArray: todoGroceriesArr)
        pagingScroll.addSubview(todoGroceries)
        
        let todoDeadlines = Todo(frame: pagingScroll.bounds)
        todoDeadlines.frame.origin.x += UIScreen.main.bounds.width * 2
        todoDeadlines.addTasks(taskArray: todoWorkArr)
        pagingScroll.addSubview(todoDeadlines)
        
        underlineLabel = UIView(frame: CGRect(x: 0, y: categoryStack.frame.origin.y, width: todoCategory[0].intrinsicContentSize.width, height: 2))
        underlineLabel.layer.zPosition = 100
        underlineLabel.backgroundColor = UIColor(red: 66/255, green: 66/255, blue: 66/255, alpha: 1)
        underlineLabel.alpha = 0
        self.view.addSubview(underlineLabel)
        
        labelTimer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(self.animateEachLabel), userInfo: nil, repeats: true)
        labelTimer.fire()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if initialLoad {
            underlineLabel.frame.origin.y = categoryStack.frame.origin.y + categoryStack.frame.height
            underlineLabel.center.x = todoCategory[0].center.x
            UIView.animate(withDuration: 0.2) {
                self.underlineLabel.alpha = 1
            }
            initialLoad = false
        }
    }
    
    @objc func animateBothLabels() {
        UIView.animate(withDuration: 1.5, animations: {
            self.welcomeLabel.frame.origin.x = 20
            self.nameLabel.frame.origin.x = 20
        })
    }
    
    @objc func animateEachLabel() {
        self.welcomeLabel.frame.origin.x = 20
        self.nameLabel.frame.origin.x = 20
    }
    
    func labelNamesAnimation(name: String?) {
        
        let labelFont = UIFont(name: "Avenir", size: 30)
        
        welcomeLabel = UILabel(frame: CGRect(x: -300, y: 90, width: 150, height: 25))
        welcomeLabel.text = "Welcome"
        welcomeLabel.font = labelFont
        self.view.addSubview(welcomeLabel)
        
        nameLabel = UILabel(frame: CGRect(x: -300, y: 130, width: 100, height: 25))
        nameLabel.text = name ?? "Midhet"
        nameLabel.font = labelFont
        self.view.addSubview(nameLabel)
    }
}

extension TodoListViewController: UIScrollViewDelegate {
    /*func getDraggablePoint(scrollView: UIScrollView) -> CGFloat {
        let progress = scrollView.contentOffset.x / (scrollView.contentSize.width - scrollView.bounds.size.width)
        let minPoint = todoCategory.first?.center.x ?? 0
        let maxPoint = todoCategory.last?.center.x ?? 0
        let pathValue = maxPoint - minPoint
        return (pathValue * progress) + minPoint
    }*/
}

extension TodoListViewController: CircleTransitionable {
    var triggerButton: UIButton {
        return addNewTodoBtn
    }
    
    var mainView: UIView {
        return self.view
    }
}
