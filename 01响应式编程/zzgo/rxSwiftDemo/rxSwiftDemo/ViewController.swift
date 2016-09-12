//
//  ViewController.swift
//  rxSwiftDemo
//
//  Created by zzgo on 16/9/12.
//  Copyright © 2016年 zzgo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBAction func touchRxSwift(sender: UIButton) {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let loginVC = storyboard.instantiateViewControllerWithIdentifier("RxLoginViewController")
    self.navigationController!.pushViewController(loginVC, animated: true)
  }

  @IBAction func touchSwift(sender: UIButton) {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let loginVC = storyboard.instantiateViewControllerWithIdentifier("LoginViewController")
    self.presentViewController(loginVC, animated: true, completion: nil)
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

