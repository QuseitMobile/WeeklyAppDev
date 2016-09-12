//
//  LoginViewController.swift
//  rxSwiftDemo
//
//  Created by zzgo on 16/9/12.
//  Copyright © 2016年 zzgo. All rights reserved.
//

import UIKit

class LoginViewController : UIViewController {
  
  @IBAction func touchDimissButton(sender: AnyObject) {
    self.dismissViewControllerAnimated(true, completion:nil)
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
}

