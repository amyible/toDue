//
//  ModalViewController.swift
//  ToDue2
//
//  Created by Amy Liu on 5/1/18.
//  Copyright © 2018 Amy Liu. All rights reserved.
//

import UIKit

class ModalViewController: UIViewController {

    @IBAction func bigButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    var name: String?
    @IBOutlet weak var taskName: UILabel!
    @IBOutlet weak var taskDeadline: UILabel!
    @IBOutlet weak var taskNotes: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.clear
        view.isOpaque = false
        taskDeadline.text = "Tomorrow"
        taskNotes.text = "Sarah's number: (555) 234-3482"
        taskNotes.numberOfLines = 0;
        taskNotes.lineBreakMode = .byWordWrapping
        taskNotes.frame.size.width = 300
        taskNotes.sizeToFit()
        taskName.text = name
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
