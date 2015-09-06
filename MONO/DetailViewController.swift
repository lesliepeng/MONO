//
//  DetailViewController.swift
//  MONO
//
//  Created by leslie on 15/9/5.
//  Copyright (c) 2015年 leslieppp. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var scrollView = UIScrollView()
    
    var userAvatar = UIImageView()
    var username = UILabel()
    var img = UIImageView()
    var msgTitle = UILabel()
    var message = UILabel()
    var backButton = UIButton()
    
    var photoInfo = PhotoInfo(){
        
        didSet{
            initView()
            userAvatar.sd_setImageWithURL(photoInfo.userAvatar)
            username.text = photoInfo.usernName
            img.sd_setImageWithURL(photoInfo.imageUrl)
            msgTitle.text = photoInfo.title
            message.text = photoInfo.photoDesc

        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func initView() {
        
        scrollView = UIScrollView(frame: self.view.bounds)
        scrollView.contentSize = CGSizeMake(CGRectGetWidth(UIScreen.mainScreen().bounds), CGRectGetHeight(UIScreen.mainScreen().bounds) * 3)
        scrollView.backgroundColor = UIColor.groupTableViewBackgroundColor()
        scrollView.scrollEnabled = true
        self.view.addSubview(scrollView)
        
        
        userAvatar = UIImageView(frame: CGRect(x: 10, y: 10, width: 20, height:20))
        scrollView.addSubview(userAvatar)
        
        username = UILabel(frame: CGRect(x: CGRectGetMaxX(userAvatar.frame) + 10, y: 10, width: 100, height: 20))
        username.font = UIFont.systemFontOfSize(10)
        scrollView.addSubview(username)
        
        img = UIImageView(frame: CGRect(x: 0, y: CGRectGetMaxY(userAvatar.frame) + 10, width: self.view.frame.width, height: self.view.frame.width * 9 / 16))
        scrollView.addSubview(img)
        
        
        msgTitle = UILabel(frame: CGRect(x: 0, y: CGRectGetMaxY(img.frame), width: self.view.frame.width, height: 50))
        msgTitle.font = UIFont.systemFontOfSize(15)
        msgTitle.textAlignment = NSTextAlignment.Center
        scrollView.addSubview(msgTitle)
        
        message = UILabel(frame: CGRect(x: 10, y: CGRectGetMaxY(msgTitle.frame), width: self.view.frame.width - 20, height: 200))
        message.numberOfLines = 0
        message.font = UIFont.systemFontOfSize(10)
        scrollView.addSubview(message)
        
        backButton = UIButton(frame:CGRect(x: 20, y: self.view.frame.height - 60, width: 40, height: 40))
        backButton.layer.cornerRadius = 20
        backButton.backgroundColor = UIColor.blackColor()
        backButton.setImage(UIImage(named: "leftarrow"), forState: UIControlState.Normal)
        backButton.titleLabel?.font = UIFont.systemFontOfSize(10)
        backButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        backButton.addTarget(self, action: "back", forControlEvents: UIControlEvents.TouchUpInside)
        scrollView.superview?.addSubview(backButton)

    }
    
    
    func back() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    

}
