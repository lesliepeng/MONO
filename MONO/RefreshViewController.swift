//
//  RefreshViewController.swift
//  MONO
//
//  Created by Leslie on 15/9/6.
//  Copyright (c) 2015年 leslieppp. All rights reserved.
//

import UIKit

class RefreshViewController: UIViewController , UITableViewDelegate , UITableViewDataSource{
    
    var tabview:UITableView!
    var monoData = MonoData()
    var items = NSMutableArray()
    var showItems = NSMutableArray()
    var page:Int = 0
    var refreshControl = UIRefreshControl()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        initRefresh()
    }
    
    
    func initView(){
        
        tabview = UITableView(frame: self.view.frame, style: UITableViewStyle.Plain)
        tabview.dataSource = self;
        tabview.delegate = self;
        tabview.backgroundColor = UIColor.groupTableViewBackgroundColor()
        self.view.addSubview(self.tabview)
        
        
        monoData.loadItems(self.tabview)
        items = monoData.items
        
        loadMore()
        
        
    }
    
    
    func initRefresh() {
        
        refreshControl.attributedTitle = NSAttributedString(string: "下拉刷新")
        
        refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        tabview.addSubview(refreshControl)
    }
    
    func refresh(sender:AnyObject)
    {
        page += 1
        loadMore()
        tabview.reloadData()
        sender.endRefreshing()
    }
    
    
    func loadMore(){
        if page == 9{
            page = 0
        }
        let nextPage = page + 1
        for index in page*2 ..< nextPage*2 {
            
            showItems.insertObject(self.items[index], atIndex: 0)
            
        }
        
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
    
    //hide
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
        
    }
    
    
    
    
    
    
    
}
