//
//  RegisterViewController.swift
//  ToDue2
//
//  Created by Amy Liu on 4/6/18.
//  Copyright © 2018 Amy Liu. All rights reserved.
//

import UIKit
import os.log

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var Email: UITextField!
    @IBOutlet weak var Username: UITextField!
    @IBOutlet weak var Password: UITextField!
    @IBOutlet weak var ConfirmPassword: UITextField!
    
    @IBOutlet weak var registerButton: UIButton!
    @IBAction func Register(_ sender: UIButton) {
        let email = self.Email.text;
        let username = self.Username.text;
        let password = self.Password.text;
        let confirm = self.ConfirmPassword.text;
        performSegue(withIdentifier: "Register", sender: self)
    }
    
    @IBAction func ToggleLogin(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.navigationController?.navigationBar.isHidden = true;
        registerButton.layer.cornerRadius = 10;
        registerButton.clipsToBounds = true;
        
        let color = UIColor(red: 203.0/255.0, green: 190.0/255.0, blue: 205.0/255.0, alpha: 1.0);
        let gradient = CAGradientLayer()
        
        gradient.frame = self.view.bounds
        gradient.colors = [UIColor.white.cgColor, color.cgColor]
        
        view.layer.insertSublayer(gradient, at: 0);
    }
}

