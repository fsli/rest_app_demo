//
//  User.swift
//  SwiftDemoApp
//
//  Created by Ferris Li on 12/20/15.
//  Copyright (c) 2015 Ferris Li. All rights reserved.
//

import Foundation

class User {
    var id: Int
    var username: String
    var picture: String
    init?(id: Int, username: String) {
        self.id = id
        self.username = username
        self.picture = ""
        if id < 0 || username.isEmpty {
            return nil
        }
    }
}
