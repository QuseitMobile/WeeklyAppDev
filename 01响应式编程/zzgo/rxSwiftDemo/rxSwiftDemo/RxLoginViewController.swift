//
//  RxLoginViewController.swift
//  rxSwiftDemo
//
//  Created by zzgo on 16/9/12.
//  Copyright © 2016年 zzgo. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

let minUsernameLength = 5
let maxUsernameLength = 10
let minPasswordLength = 5
let maxPasswordLength = 16
let disposBag = DisposeBag()


class RxLoginViewController : UIViewController {
  
  @IBOutlet weak var userNameTextFeild: UITextField!
  @IBOutlet weak var userNameLabel: UILabel!
  @IBOutlet weak var passwordTextFeild: UITextField!
  @IBOutlet weak var passwordLabel: UILabel!
  @IBOutlet weak var loginButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()

    //对字符串进行判断.
    //usernameValid&&passwordValid来接收usernameTF字符个数是否符合要求
    let usernameValid = userNameTextFeild.rx_text
      .map{$0.characters.count >= minUsernameLength && $0.characters.count <= maxUsernameLength }  //map函数 对text进行处理
      .shareReplay(1)
    let passwordValid = passwordTextFeild.rx_text
      .map{$0.characters.count >= minPasswordLength && $0.characters.count < maxPasswordLength }  //map函数 对text进行处理
      .shareReplay(1)
    
    //everythingValid组合以上两个结果
    let everythingValid = Observable.combineLatest(usernameValid, passwordValid) { $0 && $1 }
      .shareReplay(1)
 
    usernameValid
      .bindTo(passwordTextFeild.rx_enabled)  //username通过验证，passwordTF才可以输入
      .addDisposableTo(disposBag)
    
    usernameValid
      .bindTo(userNameLabel.rx_hidden)   //username通过验证，usernameLB警告消失
      .addDisposableTo(disposBag)
    
    
    passwordValid
      .bindTo(passwordLabel.rx_hidden)
      .addDisposableTo(disposBag)
    
    everythingValid
      .bindTo(loginButton.rx_enabled)   // 用户名密码都通过验证，才可以点击按钮
      .addDisposableTo(disposBag)
    
    loginButton.rx_tap
      .subscribeNext { [weak self] in
        self?.showAlert()
      }
      .addDisposableTo(disposBag)

  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func showAlert() {
    let alertView = UIAlertView(
      title: "成功",
      message: "登录成功",
      delegate: nil,
      cancelButtonTitle: "OK"
    )
    
    alertView.show()
  }
}

