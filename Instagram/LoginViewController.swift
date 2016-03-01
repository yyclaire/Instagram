//
//  LoginViewController.swift
//  Instagram
//
//  Created by Lily on 2/28/16.
//  Copyright © 2016 yyclaire. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBAction func onLogin(sender: AnyObject) {
        PFUser.logInWithUsernameInBackground(username.text!, password: password.text!) { (user:PFUser?, error:NSError?) -> Void in
            if user != nil{
                print("logged in")
                self.performSegueWithIdentifier("loginSegue", sender: nil)
            }else{
                print("not logged in")
            }
        }
    }
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
    @IBAction func onSignUp(sender: AnyObject) {
        let newUser =  PFUser()
        newUser.username = username.text!
        newUser.password = password.text!
        newUser.signUpInBackgroundWithBlock { (success:Bool, error: NSError?) -> Void in
            if success{
                print("Yay, created a user!")
                self.performSegueWithIdentifier("loginSegue", sender: nil)
            }else{
                print(error?.localizedDescription)
                if error?.code == 202{
                    print ("Username is taken")
                }
                

            }
        }
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
    }

}
