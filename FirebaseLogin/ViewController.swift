//
//  ViewController.swift
//  FirebaseLogin
//
//  Created by Morphley on 10.04.17.
//  Copyright © 2017 Morphley. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class ViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        let loginButton = FBSDKLoginButton()
        
        view.addSubview(loginButton)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        loginButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        loginButton.delegate = self
        loginButton.readPermissions = ["email","public_profile"]
        
        // Custom Login Butotn
        
        let customFBButton = UIButton(type: .system)
        customFBButton.backgroundColor = UIColor.blue
        customFBButton.setTitle("Custom FB Login Button", for: .normal)
        customFBButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        customFBButton.setTitleColor(.white, for: .normal)
        customFBButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(customFBButton)
        
        customFBButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        customFBButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 10).isActive = true
        customFBButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40).isActive = true
        customFBButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        customFBButton.addTarget(self, action: #selector(handleCustomFBLogin), for: .touchUpInside)
        
        
    }
    
    
    func handleCustomFBLogin(){
        
        FBSDKLoginManager().logIn(withReadPermissions: ["email","public_profile"], from: self) { (facebookResult, facebookError) in
            
            
            if  facebookError != nil {
                print("Custom FB Login Failed",facebookError) // Authentication Failed
                
            } else if (facebookResult?.isCancelled)!{
                
                print("User canceled FB Authentication") // AUthentication Canceled
                
            }
            else{
                
                print(facebookResult?.token.tokenString) //Authentication Successful
                
                
                FBSDKGraphRequest(graphPath: "/me", parameters: ["fields": "id, name, email, likes"]).start { (connection, result, err) in
                    if err != nil {
                        print("Failed to start Graph Request", err)
                        return
                    }
                    // In the case of a successful Graph Request we want to print out the result
                    print(result)
                    
                }

            }
        }
        
    }
    
    // Sent to the delegate when the button was used to logout.
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("Did logout of Facebook")
    }
    
    
    //Sent to the delegate when the button was used to login.
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        
        if error != nil{
            print(error)
            return
        }
        
        print("Succesfully logged in with Facebook")
        
        // Also can use showEmailAddress
        
        FBSDKGraphRequest(graphPath: "/me", parameters: ["fields": "id, name, email, likes"]).start { (connection, result, err) in
            if err != nil {
                print("Failed to start Graph Request", err)
                return
            }
            // In the case of a successful Graph Request we want to print out the result
            print(result)
            
        }
    }
    
    
    
    func showEmailAddress(){
        
        FBSDKGraphRequest(graphPath: "/me", parameters: ["fields": "id, name, email, likes"]).start { (connection, result, err) in
            if err != nil {
                print("Failed to start Graph Request", err)
                return
            }
            // In the case of a successful Graph Request we want to print out the result
            print(result)
            
        }
    
    
    }
    
    
    
    
    
}

