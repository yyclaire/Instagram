//
//  HomeViewController.swift
//  Instagram
//
//  Created by Lily on 2/28/16.
//  Copyright © 2016 yyclaire. All rights reserved.
//

import UIKit
import Parse

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
    @IBOutlet weak var tableView: UITableView!
    
     var media: [UserMedia]!
    override func viewDidLoad(){
        let customTabBarItem:UITabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "house-7")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal), selectedImage: UIImage(named: "house-7"))
        self.tabBarItem = customTabBarItem
        
        
        let TabBarItem:UITabBarItem = UITabBarItem(title: "Capture", image: UIImage(named: "upload-7")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal), selectedImage: UIImage(named: "upload-7"))
        let CV = CaptureViewController()
        
        CV.tabBarItem = TabBarItem
        
         NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateMedia:", name: "PostSubmitted", object: nil)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 500
        
        // construct PFQuery
        let query = PFQuery(className: "UserMedia")
        query.orderByDescending("createdAt")
        query.includeKey("author")
        query.limit = 20
        
        // fetch data asynchronously
        query.findObjectsInBackgroundWithBlock { (media: [PFObject]?, error: NSError?) -> Void in
            if let media = media {
                let tempMedia = UserMedia.mediaWithArray(media)
                UserMedia.processFilesWithArray(tempMedia, completion: { () -> Void in
                    print("reloading table")
                    self.tableView.reloadData()
                })
                self.media = tempMedia
            } else {
                // handle error
                print("error fetching data")
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if media != nil {
            return media.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("InstaCell", forIndexPath: indexPath) as! InstaCell
        
        cell.media = media[indexPath.row]
        
        return cell
    }
    
    func updateMedia(notification: NSNotification) {
        let newPost = notification.userInfo!["Post"] as! UserMedia
        media.insert(newPost, atIndex: 0)
        tableView.reloadData()
    }

 
    

}
