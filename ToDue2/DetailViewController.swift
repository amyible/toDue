//
//  DetailViewController.swift
//  ToDue2
//
//  Created by Amy Liu on 4/20/18.
//  Copyright © 2018 Amy Liu. All rights reserved.
//

import UIKit
import os.log

class DetailViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var taskNameField: UITextField!
    @IBOutlet weak var taskDurationField: UITextField!
    @IBOutlet weak var taskNotesField: UITextView!
    @IBOutlet weak var saveEditBtn: UIBarButtonItem!
    
    var task: Task?
    
    @objc func checkBoxAction(_ sender: UIButton)
    {
        if (sender.isSelected) //&& !(task?.important)!) || (!sender.isSelected && (task?.important)!)
        {
            sender.isSelected = false
            let btnImage    = UIImage(named: "unCheckBoxImage")!
            sender.setBackgroundImage(btnImage, for: UIControlState())
        }else {
            sender.isSelected = true
            let btnImage    = UIImage(named: "checkBoxImage")!
            sender.setBackgroundImage(btnImage, for: UIControlState())
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        taskNameField.delegate = self;
        taskDurationField.delegate = self;
        //taskNotesField.delegate = self as? UITextViewDelegate;
        
        var btnImage    = UIImage(named: "unCheckBoxImage")!
        if let task = task {
            taskNameField.text = task.name
            taskDurationField.text = task.duration.description
            taskNotesField.text = task.notes
            if task.important {
                btnImage    = UIImage(named: "checkBoxImage")!
            }
        }
        
        let color = UIColor(red: 203.0/255.0, green: 190.0/255.0, blue: 205.0/255.0, alpha: 1.0);
        let gradient = CAGradientLayer()
        
        gradient.frame = self.view.bounds
        gradient.colors = [UIColor.white.cgColor, color.cgColor]
        
        view.layer.insertSublayer(gradient, at: 0);
        
        let datePicker = UIDatePicker(frame:CGRect(x: 125, y: 300, width: 240, height: 150))
        datePicker.minuteInterval = 15;
        datePicker.minimumDate = NSDate() as Date?;
        if (task?.deadline != nil) {
            datePicker.date = (task?.deadline)!;
        }
        else {
            datePicker.date = NSDate() as Date
        }
        self.view.addSubview(datePicker)
        
        let imageButton : UIButton = UIButton(frame: CGRect(x: 230, y: 445, width: 20, height: 20))
        imageButton.setBackgroundImage(btnImage, for: UIControlState())
        imageButton.addTarget(self, action: #selector(ViewController.checkBoxAction(_:)), for: .touchUpInside)
        self.view.addSubview(imageButton)

    }
    
    // This method lets you configure a view controller before it's presented.
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button === saveEditBtn else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        let name = taskNameField.text ?? ""
        let duration = taskDurationField.text ?? ""
        let notes = taskNotesField.text ?? ""
        let important = true
        let deadline = NSDate() as Date
        
        // Set the meal to be passed to MealTableViewController after the unwind segue.
        task = Task(name: name, duration:Double(duration)!, deadline: deadline, important: important, notes: notes)
    }
}

