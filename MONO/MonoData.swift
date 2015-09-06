//
//  MonoData.swift
//  MONO
//
//  Created by leslie on 15/9/3.
//  Copyright (c) 2015年 leslieppp. All rights reserved.
//

import UIKit
import Alamofire

class MonoData {
    
    var items = NSMutableArray()
    
    func loadItems(tabview:UITableView){
        
        // 这里判断本地是否存储了之前下载的数据，如果存在就从本地读取，如果没有，就在此从网络请求
        if let data = NSUserDefaults.standardUserDefaults().valueForKey("monoData") as? NSData{
            self.items = NSKeyedUnarchiver.unarchiveObjectWithData(data) as! NSMutableArray;
            tabview.reloadData()
        }else{
            println("开始下载。。。")
            //从500px上获取图片，图片信息资源，这里使用了Alamofire,这是一个封装了网络请求的库
            Alamofire.request(.GET, "https://api.500px.com/v1/photos", parameters: ["consumer_key": "6I5ZOBxM1JxZPWHa0qVsGXgBl8iD3VJ1lBjWJzLJ"]).responseJSON() {
                (_, _, JSON, _) in
                println("下载完成。。。")
                //这一步的意思是，如果下载成功，就将数据保存在本地
                if ((JSON) != nil){
                    println(JSON)
                    let photos = (JSON!.valueForKey("photos") as! [NSDictionary])
                    var count:Int = 0
                    let total = photos.count
                    for photo:NSDictionary in photos {
                        count += 1
                        let photoInfo = PhotoInfo()
                        photoInfo.configDic(photo)
                        self.items.addObject(photoInfo)
                    }
                    
                    let data:NSData = NSKeyedArchiver.archivedDataWithRootObject(self.items)
                    NSUserDefaults.standardUserDefaults().setValue(data, forKey: "monoData")
                    tabview.reloadData()
                    println(data)
                    
                }else{
                    println("下载失败。。。")
                }
            }
        }
        
        
    }
    

}


class PhotoInfo: NSObject {
    
    var imageUrl:NSURL?
    var usernName:String?
    var userAvatar:NSURL?
    var photoName:String?
    var photoDesc:String?
    var title:String?

    
    
    override init() {
        super.init()
    }
    
    init(coder aDecoder:NSCoder!){
        self.imageUrl = aDecoder.decodeObjectForKey("imageUrl") as? NSURL
        self.usernName = aDecoder.decodeObjectForKey("usernName") as? String
        self.userAvatar = aDecoder.decodeObjectForKey("userAvatar") as? NSURL
        self.photoName = aDecoder.decodeObjectForKey("photoName") as? String
        self.photoDesc = aDecoder.decodeObjectForKey("photoDesc") as? String
        self.title = aDecoder.decodeObjectForKey("title") as? String

        
    }
    
    func encodeWithCoder(aCoder:NSCoder!){
        
        aCoder.encodeObject(imageUrl, forKey: "imageUrl")
        aCoder.encodeObject(usernName, forKey: "usernName")
        aCoder.encodeObject(userAvatar, forKey: "userAvatar")
        aCoder.encodeObject(photoName, forKey: "photoName")
        aCoder.encodeObject(photoDesc, forKey: "photoDesc")
        aCoder.encodeObject(title, forKey: "title")

        
    }
    
    
    func configDic(item:NSDictionary){
        
        let imageURLString = item["image_url"] as! String
        self.imageUrl = NSURL(string:imageURLString)!
        
        self.photoDesc = item["description"] as? String
        
        let user:NSDictionary = item["user"] as! NSDictionary
        let avatars:NSDictionary = user["avatars"] as! NSDictionary
        let avatarsDic:NSDictionary = avatars["tiny"] as! NSDictionary
        let avatarURLString = avatarsDic["https"] as! String
        self.userAvatar = NSURL(string: avatarURLString)!

        self.usernName = user["fullname"] as? String
        self.title = item["name"] as? String
        
    }
    
}












