//
//  DatabaseManager.swift
//  FashionFriend
//
//  Created by Justin Brown on 8/29/20.
//  Copyright © 2020 Justin Brown. All rights reserved.
//

import Foundation
import FirebaseDatabase

public class DatabaseManager {
    
    // DB Manager instance
    static let shared = DatabaseManager()
    
    // A reference to our Firebase DB
    private let database = Database.database().reference()
    
    /// Check if username and email is available
    /// - Parameters
    ///     - email: String representing email
    ///     - username: String representing username
    public func canCreateNewUser(email: String, username: String, completion: (Bool) -> Void) {
        completion(true)
    }
    
    /// Inserts new user data into database
    /// - Parameters
    ///     - email: String representing email
    ///     - username: String representing username
    ///     - completion: Async callback for result if database entry succeeded
    public func insertNewUser(email: String, username: String, completion: @escaping (Bool) -> Void) {
        // Get a reference to the "child" entry that is defined by the email (id), then set
        //  the username property to the passed username
        database.child(email.safeDatabaseKey()).setValue(["username": username]) { error, _ in
            if error == nil {
                completion(true)
                return
            } else {
                completion(false)
                return
            }
        }
    }
}
