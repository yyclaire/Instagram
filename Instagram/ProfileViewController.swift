//
//  ProfileViewController.swift
//  Instagram
//
//  Created by Lily on 2/28/16.
//  Copyright © 2016 yyclaire. All rights reserved.
//

import UIKit
import Parse

let logoutNotification = "logoutNotification"
class ProfileViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func Logout(sender: AnyObject) {
        PFUser.logOut()
        
        NSNotificationCenter.defaultCenter().postNotificationName(logoutNotification, object: nil)
    }
    


}
