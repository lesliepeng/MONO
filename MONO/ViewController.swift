//
//  ViewController.swift
//  MONO
//
//  Created by leslie on 15/9/3.
//  Copyright (c) 2015年 leslieppp. All rights reserved.
//

import UIKit
import Alamofire


class ViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{

    //var tabview = UITableView()
    //最好这样写
    var tabview:UITableView!
    
    var monoData = MonoData()
    var items = NSMutableArray()
    var showItems = NSMutableArray()
    var showNum:Int = 0
    var header = UILabel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        initHeader()
        monoData.loadItems(self.tabview)
        self.items = monoData.items
        //self.showItems.addObject(self.items.objectAtIndex(showNum))
        
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    //初始化试图
    func initView(){
        

        self.tabview = UITableView(frame: self.view.frame, style: UITableViewStyle.Plain)
        
        self.tabview.dataSource = self;
        self.tabview.delegate = self;
        self.tabview.backgroundColor = UIColor.groupTableViewBackgroundColor()
        
        self.view.addSubview(self.tabview)
    }
    
    func initHeader(){

        self.header = UILabel(frame: CGRect(x: 0, y: -50, width: self.view.frame.width, height: 50))
        self.header.text = "下一个MONO"
        self.header.textAlignment = NSTextAlignment.Left
        self.tabview.addSubview(self.header)
    }
    

    // tableview delegate , datasource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.showItems.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:mycell = mycell(style: UITableViewCellStyle.Default, reuseIdentifier: "mycell") as mycell
        cell.selectionStyle = UITableViewCellSelectionStyle.None

        cell.photoInfo = self.showItems.objectAtIndex(indexPath.row) as! PhotoInfo
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return self.view.frame.width
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        let photoInfo = self.showItems[indexPath.row] as! PhotoInfo
        
        var detailVc = DetailViewController()
        detailVc.photoInfo = photoInfo
        
        navigationController?.pushViewController(detailVc, animated: true)
        
        
    }
    
    


    
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    
    
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let y = scrollView.contentOffset.y
        if (y < -50){
            self.showNum += 1
            if (self.showNum < self.items.count){
                let photoInfo:PhotoInfo = self.items.objectAtIndex(self.showNum) as! PhotoInfo
                if (self.showItems.containsObject(photoInfo)){
                    //do nothing
                }else{
                    self.tabview.beginUpdates()
                    self.showItems.insertObject(self.items.objectAtIndex(self.showNum), atIndex: 0)
                    let indexPaths = [NSIndexPath(forRow: 0, inSection: 0)]
                    self.tabview.insertRowsAtIndexPaths(indexPaths, withRowAnimation: UITableViewRowAnimation.Top)
                    self.tabview.endUpdates()
                    let indexpath = NSIndexPath(forRow: 0, inSection: 0)
                    self.tabview.cellForRowAtIndexPath(indexpath)?.alpha = 0
                    UIView.animateWithDuration(1, animations: {
                        self.tabview.cellForRowAtIndexPath(indexpath)?.alpha = 1
                    })
                }
            }

        }


        
        

    }
    
    
//    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
//        scrollView.contentInset = UIEdgeInsetsZero
//        UIView.animateWithDuration(0.3, animations: {
//            scrollView.setContentOffset(CGPointMake(0, scrollView.contentOffset.y), animated: false)
//        })
//        
//        UIView.animateWithDuration(0.1, delay: 0, options: UIViewAnimationOptions.AllowUserInteraction, animations: {
//            scrollView.contentInset = UIEdgeInsetsMake(50, 0, 0, 0)
//            }, completion: nil)
//        
//    }
    


}









