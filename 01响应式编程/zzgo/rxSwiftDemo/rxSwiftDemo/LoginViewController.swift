//
//  LoginViewController.swift
//  rxSwiftDemo
//
//  Created by zzgo on 16/9/12.
//  Copyright © 2016年 zzgo. All rights reserved.
//

import UIKit


//let minUsernameLength = 5
//let maxUsernameLength = 10
//let minPasswordLength = 5
//let maxPasswordLength = 16
//let disposBag = DisposeBag()

class LoginViewController : UIViewController, UITextFieldDelegate {
  
  @IBOutlet weak var userNameInput: UITextField!
  @IBOutlet weak var userNameLabel: UILabel!
  
  @IBOutlet weak var passwordTextFeild: UITextField!
  @IBOutlet weak var passwordLabel: UILabel!
  
  @IBOutlet weak var loginButton: UIButton!
  
  @IBAction func touchDimissButton(sender: AnyObject) {
    self.dismissViewControllerAnimated(true, completion:nil)
  }
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    userNameInput.delegate=self
    
    //want save when textField edting
    let notificationCenter = NSNotificationCenter.defaultCenter()
    notificationCenter.addObserver(self,
                                   selector:#selector(LoginViewController.textFieldDidChange(_:)),
                                   name: UITextFieldTextDidChangeNotification,
                                   object: nil)
  }
  
  func textFieldShouldReturn(textField: UITextField) -> Bool {
    // Hide the keyboard.
    textField.resignFirstResponder()
    return true
  }
  
  func textFieldDidChange(sender : AnyObject)  {
    //假如是用户名输入
    if let notification = sender as? NSNotification,
      textFieldChanged = notification.object as? UITextField
      where textFieldChanged == self.userNameInput {
      //得到字符串长度
      let length = userNameInput.text?.characters.count
      
      let userNameInputValid  = length>minUsernameLength && length<maxUsernameLength
      if userNameInputValid {
        userNameLabel.hidden=true
        passwordTextFeild.userInteractionEnabled=true
        passwordTextFeild.backgroundColor=UIColor.whiteColor()
        loginButton.userInteractionEnabled=true
        loginButton.backgroundColor=UIColor.whiteColor()
      } else {
        userNameLabel.hidden=false
        userNameLabel.text="用户名必须是5-10位"
        passwordTextFeild.userInteractionEnabled=false
        passwordTextFeild.backgroundColor=UIColor.grayColor()
        loginButton.userInteractionEnabled=false
        loginButton.backgroundColor=UIColor.grayColor()
      }
    }
   
    if let notification = sender as? NSNotification,
      textFieldChanged = notification.object as? UITextField
      where textFieldChanged == self.passwordTextFeild {
      //得到字符串长度
      let length = passwordTextFeild.text?.characters.count
      
      let passwordTextFeildValid  = length>minPasswordLength && length<maxPasswordLength
      if passwordTextFeildValid {
         passwordLabel.hidden=true
      } else {
         passwordLabel.hidden=false
      }
    }

    
  }
  
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
}

