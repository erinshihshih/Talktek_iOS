//
//  LogInViewController.swift
//  talkTek
//
//  Created by Mac on 2017/11/30.
//  Copyright © 2017年 Talktek Inc. All rights reserved.
//

import UIKit
import Firebase
import FBSDKLoginKit

class MainLogInViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func facebookLogin(sender: UIButton) {
    let fbLoginManager = FBSDKLoginManager()
    fbLoginManager.logIn(withReadPermissions: ["public_profile", "email"], from: self) { (result, error) in
      if let error = error {
        print("Failed to login: \(error.localizedDescription)")
        return
      }
      
      guard let accessToken = FBSDKAccessToken.current() else {
        print("Failed to get access token")
        return
      }
      
      let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)
      
      // Perform login by calling Firebase APIs
      Auth.auth().signIn(with: credential, completion: { (user, error) in
        if let error = error {
          print("Login error: \(error.localizedDescription)")
          let alertController = UIAlertController(title: "Login Error", message: error.localizedDescription, preferredStyle: .alert)
          let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
          alertController.addAction(okayAction)
          self.present(alertController, animated: true, completion: nil)
          
          return
        }
        
        // Present the main view
        if let viewController = self.storyboard?.instantiateViewController(withIdentifier: "MainView") {
          UIApplication.shared.keyWindow?.rootViewController = viewController
          self.dismiss(animated: true, completion: nil)
        }
        
      })
      
    }
  }
  
  
  
}
