//
//  LoginViewController.swift
//  MONO
//
//  Created by Leslie on 15/9/7.
//  Copyright (c) 2015年 leslieppp. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    var username:UITextField!
    var password:UITextField!
    var signup:UIButton!
    var login:UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        initview()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initview(){
        username = UITextField(frame: CGRect(x: 20, y: 100, width: self.view.frame.width - 40, height: 30))
        username.placeholder = "username"
        self.view.addSubview(username)
        
        password = UITextField(frame: CGRect(x: 20, y: 150, width: self.view.frame.width - 40, height: 30))
        password.placeholder = "password"
        self.view.addSubview(password)
        
        signup = UIButton(frame: CGRect(x: 20, y: 250, width: self.view.frame.width - 40, height: 30))
        signup.backgroundColor = UIColor.blueColor()
        signup.setTitle("sign up", forState: UIControlState.Normal)
        signup.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        signup.addTarget(self, action: "signupClicked", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(signup)
        
        login = UIButton(frame: CGRect(x: 20, y: 200, width: self.view.frame.width - 40, height: 30))
        login.backgroundColor = UIColor.blueColor()
        login.setTitle("login in", forState: UIControlState.Normal)
        login.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        login.addTarget(self, action: "loginClicked", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(login)
        
        
    }
    
    func signupClicked(){
        let name = username.text
        let psd = password.text
        if (count(name) > 0 && count(psd) > 0){
            if let unknownpsd:AnyObject = NSUserDefaults.standardUserDefaults().objectForKey(username.text){
                showAlert("该用户名已经存在")
            }else{
                NSUserDefaults.standardUserDefaults().setObject(password.text, forKey: username.text)
                NSUserDefaults.standardUserDefaults().synchronize()
                var vc = RefreshViewController()
                self.navigationController?.pushViewController(vc, animated: true)
                showAlert("登陆成功")
            }
            
        }else{
            showAlert("输入信息")
        }
    }
    
    func loginClicked(){
        
        let name = username.text
        let psd = password.text
        if (count(name) > 0 && count(psd) > 0){
            if let curpsd:AnyObject = NSUserDefaults.standardUserDefaults().objectForKey(username.text){
                if password.text == curpsd as! String{
                    var vc = RefreshViewController()
                    self.navigationController?.pushViewController(vc, animated: true)
                    showAlert("登陆成功")
                }else{
                    showAlert("密码错误")
                }
            }else{
                
                showAlert("用户名不存在，请先注册")
            }
            
        }else{
            showAlert("输入信息")
        }
        
    }
    
    func showAlert(msg:String){
        var alert = UIAlertView(title: "", message: msg, delegate: nil, cancelButtonTitle: "确定")
        alert.show()
    }

}
