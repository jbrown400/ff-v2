//
//  AuthManager.swift
//  FashionFriend
//
//  Created by Justin Brown on 8/29/20.
//  Copyright © 2020 Justin Brown. All rights reserved.
//

import Foundation
import FirebaseAuth

public class AuthManager {
    
    // Our auth manger instance
    static let shared = AuthManager()
    
    public func registerUser(username: String, email: String, password: String, completion: @escaping (Bool) -> Void){
        
        DatabaseManager.shared.canCreateNewUser(email: email, username: username) { canCreate in
            if canCreate {
                Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                    guard error == nil, result != nil else {
                        // Firebase could not create account
                        completion(false)
                        return
                    }
                    
                    // Insert into DB
                    DatabaseManager.shared.insertNewUser(email: email, username: username) { inserted in
                        if inserted {
                            completion(true)
                            return
                        } else {
                            completion(false)
                            return
                        }
                    }
                }
            } else {
                // Either username or email does not exist
                completion(false)
            }
        }
    }
    
    public func loginUser(username: String?, email: String?, password: String, completion: @escaping (Bool) -> Void) {
        if let email = email {
            // email log in
            Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
                guard authResult != nil, error == nil else {
                    completion(false)
                    return
                }
                
                completion(true)
            }
        } else if let username = username {
            // todo username log in
            print(username)
        }
    }
    
    public func logout(completion: (Bool) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(true)
            return
        } catch {
            print(error)
            completion(false)
            return
        }
    }
    
}
