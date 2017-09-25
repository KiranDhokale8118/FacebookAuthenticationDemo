//
//  ViewController.swift
//  LoginWithFacebookDemo
//
//  Created by Aniket on 13/07/17.
//  Copyright © 2017 Supriya Jagtap. All rights reserved.
//

import UIKit
import FBSDKLoginKit     
import FBSDKShareKit
import FBSDKCoreKit

class ViewController: UIViewController,FBSDKLoginButtonDelegate
{

    @IBOutlet var btn: FBSDKLoginButton!
     var dict : [String : AnyObject]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if  FBSDKAccessToken.current() != nil
        {
            let loginView = FBSDKLoginButton()
            self.view.addSubview(loginView)
            loginView.center = self.view.center
            loginView.readPermissions = ["public_profile", "email", "user_friends"]
            loginView.delegate = self
            self.getFBUserData()
        }
        else
        {
            let loginView = FBSDKLoginButton()
            self.view.addSubview(loginView)
            loginView.center = self.view.center
            loginView.readPermissions = ["public_profile", "email", "user_friends"]
            loginView.delegate = self
        }
 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        print("in  first fun")
        if error != nil
        {
            print("error")
        } else if result.isCancelled {
            print("cancelled")
        } else if result.grantedPermissions.contains("email")
        {
            print("token: \(result.token.tokenString)")
            print("user_id: \(result.token.userID)")
        }
        self.getFBUserData()
    }

    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("User Logged Out")
    }
    
    
    
    
       @IBAction func LoginPressed(_ sender: AnyObject) {
        
        var login: FBSDKLoginManager = FBSDKLoginManager()
        
       login.logIn(withReadPermissions: ["public_profile", "user_friends"], from: self) { (
            result , error) in
        
        if (error != nil)
        {
            print("error**********")
        }
        else if (result?.isCancelled)!
        {
              print("calcel**********")
        }
        else
        {
            // If you ask for multiple permissions at once, you
            // should check if specific permissions missing
            if (result?.grantedPermissions.contains("user_friends"))!{
                //Do work
                
                print("permission granted in function")
            }
        }
        
        
        
//        }
//        
//        
//        
//        })
        
//        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
//        
//    fbLoginManager.logIn(withReadPermissions:  ["public_profile", "user_friends"], from: self) { (result, error) in
//        
//            
//                        if (error == nil){
//                            let fbloginresult : FBSDKLoginManagerLoginResult = result!
//                            if fbloginresult.grantedPermissions != nil {
//                                if(fbloginresult.grantedPermissions.contains("email"))
//                                {
//                                    self.getFBUserData()
//                                 //   fbLoginManager.logOut()
//                                }
//                            }
//                        }
                    }
        }
            
  
    
    
    func getFBUserData()
    {
        let graph : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: nil)
        graph.start(completionHandler: ({
            (connection,result,error) -> Void in
            if error != nil
            {
                
                
            }
            else
            {
                print("fetched user: \(result)")
        
            }
        
        
        }))
 }
}

