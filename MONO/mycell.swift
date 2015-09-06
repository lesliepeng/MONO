//
//  mycell.swift
//  MONO
//
//  Created by leslie on 15/9/3.
//  Copyright (c) 2015年 leslieppp. All rights reserved.
//

import UIKit
import Alamofire


class mycell: UITableViewCell {
    
    var img = UIImageView()
    var labMessage = UILabel()
    var userAvatar = UIImageView()
    var username = UILabel()
    var title = UILabel()
    var shareBtn = UIButton()
    var likeBtn = UIButton()
    var commentBtn = UIButton()
    
    var photoInfo = PhotoInfo(){
        
        didSet{
            self.img.sd_setImageWithURL(photoInfo.imageUrl)
            self.labMessage.text = photoInfo.photoDesc
            self.userAvatar.sd_setImageWithURL(photoInfo.userAvatar)
            self.username.text = photoInfo.usernName
            self.title.text = photoInfo.title
        }
    }
    
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        

        self.backgroundColor = UIColor.groupTableViewBackgroundColor()
        let screenWidth: CGFloat = UIScreen.mainScreen().bounds.width
        
        //add the main image
        self.img = UIImageView(frame: CGRectMake(0, 0, screenWidth, screenWidth * 9 / 16))
        self.img.contentMode = UIViewContentMode.ScaleToFill
        self.contentView .addSubview(self.img)
        
        //add author avatar
        self.userAvatar = UIImageView(frame: CGRectMake(10, 10, 20, 20))
        self.userAvatar.layer.masksToBounds = true
        self.userAvatar.layer.cornerRadius = 10
        self.img.addSubview(self.userAvatar)
        
        //add username
        self.username = UILabel(frame: CGRectMake(CGRectGetMaxX(self.userAvatar.frame) + 5, 10, 100, 20))
        self.username.textAlignment = NSTextAlignment.Left
        self.username.font = UIFont.systemFontOfSize(10)
        self.username.textColor = UIColor.whiteColor()
        self.img.addSubview(self.username)
        
        //add title
        self.title = UILabel(frame: CGRectMake(0, CGRectGetMaxY(self.img.frame), screenWidth, screenWidth * 1 / 16))
        self.title.font = UIFont.systemFontOfSize(15)
        self.title.textColor = UIColor.blackColor()
        self.title.textAlignment = NSTextAlignment.Center
        self.contentView.addSubview(self.title)

        //add article
        self.labMessage = UILabel(frame: CGRectMake(10, CGRectGetMaxY(self.title.frame), screenWidth - 20, screenWidth * 4 / 16))
        self.labMessage.numberOfLines = 0
        self.labMessage.font = UIFont.systemFontOfSize(12)
        self.contentView.addSubview(self.labMessage)
        
        //add share button
        self.shareBtn = UIButton(frame: CGRect(x: 10, y: CGRectGetMaxY(self.labMessage.frame) + screenWidth / 32, width: 20, height: screenWidth * 1 / 16))
        self.shareBtn.setImage(UIImage(named: "sharebtn"), forState: .Normal)
        //self.shareBtn.addTarget(self, action: "btnTouched:", forControlEvents:.TouchUpInside)
        self.contentView.addSubview(self.shareBtn)
        
        //add like button
        self.likeBtn = UIButton(frame: CGRect(x:CGRectGetMaxX(self.shareBtn.frame)+20 , y: CGRectGetMaxY(self.labMessage.frame) + screenWidth / 32, width: 20, height: screenWidth * 1 / 16))
        //self.likeBtn.backgroundColor = UIColor.blueColor()
        self.likeBtn.setImage(UIImage(named: "likebtn"), forState: .Normal)
        self.contentView.addSubview(self.likeBtn)
        
        //add comment button
        self.commentBtn = UIButton(frame: CGRect(x:CGRectGetMaxX(self.likeBtn.frame)+20, y: CGRectGetMaxY(self.labMessage.frame) + screenWidth / 32, width: 20, height: screenWidth * 1 / 16))
        //self.commentBtn.backgroundColor = UIColor.yellowColor()
        self.commentBtn.setImage(UIImage(named: "commentbtn"), forState: .Normal)
        self.contentView.addSubview(self.commentBtn)
        
    }
    

    

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
