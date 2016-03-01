//
//  CaptureViewController.swift
//  Instagram
//
//  Created by Lily on 2/28/16.
//  Copyright © 2016 yyclaire. All rights reserved.
//

import UIKit
import Parse

class CaptureViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
     @IBOutlet weak var caption: UITextField!
     @IBOutlet weak var imageToUpload: UIImageView!
     @IBOutlet weak var uploadView: UIView!

   
    let tapUpload = UITapGestureRecognizer()
    let vc = UIImagePickerController()
 
    override func viewWillAppear(animated: Bool) {
        
        let customTabBarItem:UITabBarItem = UITabBarItem(title: "Capture", image: UIImage(named: "upload-7")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal), selectedImage: UIImage(named: "upload-7"))
        
        self.tabBarItem = customTabBarItem
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
        vc.delegate = self
        vc.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            vc.sourceType = UIImagePickerControllerSourceType.Camera
        } else {
            vc.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        }
        
        tapUpload.addTarget(self, action: "presentImage")
        uploadView.addGestureRecognizer(tapUpload)
        uploadView.userInteractionEnabled = true
    }
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func presentImage() {
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        //let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        
        imageToUpload.image = editedImage
        uploadView.hidden = true
        
        self.dismissViewControllerAnimated(true) { () -> Void in
            print("image dismissed")
        }
    }
    
  
    
    func resize(image: UIImage, newSize: CGSize) -> UIImage {
        let resizeImageView = UIImageView(frame: CGRectMake(0, 0, newSize.width, newSize.height))
        resizeImageView.contentMode = UIViewContentMode.ScaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    @IBAction func onSubmit(sender: AnyObject) {
        if imageToUpload.image != nil {
            UserMedia.postUserImage(imageToUpload.image, withCaption: caption.text, withCompletion: { (result) -> Void in
                print("uploaded")
                let newPost = UserMedia(image: self.imageToUpload.image!, caption: self.caption.text!, likesCount: 0, commentsCount: 0)
                
                self.imageToUpload.image = nil
                self.caption.text = nil
                self.uploadView.hidden = false
                
                NSNotificationCenter.defaultCenter().postNotificationName("PostSubmitted", object: nil, userInfo: ["Post" : newPost])
                
                self.tabBarController?.selectedIndex = 0
            })
        }
    }
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}

