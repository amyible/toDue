//
//  LoginViewController.swift
//  ToDue2
//
//  Created by Amy Liu on 4/6/18.
//  Copyright © 2018 Amy Liu. All rights reserved.
//

import UIKit
import os.log

class LoginViewController: UIViewController {
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginTextField: UITextField!
    
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var registerBtn: UIButton!
    
    @IBAction func loginButton(_ sender: UIButton) {
        let username = self.loginTextField.text;
        let password = self.passwordTextField.text;
        print("logging in \(username)")
    }
    
    @IBAction func ToggleRegister(_ sender: UIButton) {
        performSegue(withIdentifier: "ToggleRegister", sender: self)
    }
    //    @IBAction func login(sender: AnyObject) {
//        let username = self.loginTextField.text
//        let password = self.passwordTextField.text
//
//        LoginService.sharedInstance.loginWithCompletionHandler(username: username!, password: password!) { (error) -> Void in
//
//            if ((error) != nil) {
//                // Move to a background thread to do some long running work
//                DispatchQueue.global(qos: .userInitiated).async {
//                    let alert = UIAlertController(title: "Why are you doing this to me?!?", message: error, preferredStyle: .alert)
//                    alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
//                    self.present(alert, animated: true, completion: nil)
//                    }
//            } else {
//
//                DispatchQueue.global(qos: .userInitiated).async {
//                    let controllerId = LoginService.sharedInstance.isLoggedIn() ? "Welcome" : "Login";
//
//                    let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//                    let initViewController: UIViewController = storyboard.instantiateViewController(withIdentifier: controllerId) as UIViewController
//                    self.present(initViewController, animated: true, completion: nil)
//                }
//            }
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.navigationController?.navigationBar.isHidden = true;
        
        let color = UIColor(red: 203.0/255.0, green: 190.0/255.0, blue: 205.0/255.0, alpha: 1.0);
        let gradient = CAGradientLayer()
        
        gradient.frame = self.view.bounds
        gradient.colors = [UIColor.white.cgColor, color.cgColor]
        
        view.layer.insertSublayer(gradient, at: 0);
        
        loginBtn.layer.cornerRadius = 10;
        loginBtn.clipsToBounds = true;
        registerBtn.layer.cornerRadius = 10;
        registerBtn.clipsToBounds = true;
    }
}
