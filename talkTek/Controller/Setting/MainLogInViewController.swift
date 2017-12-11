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
import FirebaseAuth
import FirebaseDatabase

class MainLogInViewController: UIViewController, FBSDKLoginButtonDelegate, GIDSignInUIDelegate, GIDSignInDelegate {
  
 
  @IBOutlet weak var facebook_Button: FBSDKLoginButton!
  var databaseRef: DatabaseReference!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    listenToState()
    
    // Initialize sign-in
    GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
    GIDSignIn.sharedInstance().delegate = self
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func listenToState(){
    Auth.auth().addStateDidChangeListener() { (auth, user) in
      if user != nil{
        self.dismiss(animated: true, completion: nil)
        //self.performSegue(withIdentifier: "HomeTabSegue", sender: self)
      }
      else
      {
        self.facebook_Button.readPermissions = ["public_profile", "email"]
        self.facebook_Button.delegate = self
        self.facebook_Button.isHidden = false
      }
    }
  }
  

  // Google
  func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
    // ...
    if let error = error {
      print(error.localizedDescription)
      return
    }
    
    guard let authentication = user.authentication else { return }
    let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
    Auth.auth().signIn(with: credential){(user, error) in
      print("Google Sign In to Firebase")
      self.databaseRef = Database.database().reference()
      self.databaseRef.child("Users").child(user!.uid).observeSingleEvent(of: .value, with: { (snapshot) in
        let snapshot = snapshot.value as? NSDictionary
        if(snapshot == nil)
        {
          self.databaseRef.child("Users").child(user!.uid).setValue(["name" : user?.displayName, "account": user?.email])
        }
      })
      self.dismiss(animated: true, completion: nil  )

    }
    // ...
  }
  func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
    if let error = error {
      print(error.localizedDescription)
      return
    }
    
    try! Auth.auth().signOut()
    
  }
  
  
  // Facebook
  func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
    print("user has log in fb")
    
    self.facebook_Button.isHidden = true
    
    
    if (error != nil)
    {
      print(error.localizedDescription)
      self.facebook_Button.isHidden = false
    }
    else if(result.isCancelled)
    {
      print("facebook cancelled is pressed")
      self.facebook_Button.isHidden = false
    }
    else
    {
      let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
      Auth.auth().signIn(with: credential) { (user, error) in
        print("Facebook user has log into firebase")
        self.databaseRef = Database.database().reference()
        self.databaseRef.child("Users").child(user!.uid).observeSingleEvent(of: .value, with: { (snapshot) in
          let snapshot = snapshot.value as? NSDictionary
          if(snapshot == nil)
          {
            self.databaseRef.child("Users").child(user!.uid).setValue(["name" : user?.displayName, "account": user?.email])
            
            
          }
        })
        self.dismiss(animated: true, completion: nil )

      }
    }

  }
  
  func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
    print("user has log out")
  }
  
  @IBAction func LogIn_Button_Tapped(_ sender: UIButton) {
    
    self.dismiss(animated: true, completion: nil  )
  }
  
}