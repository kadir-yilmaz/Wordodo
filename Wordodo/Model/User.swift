//
//  User.swift
//  Wordodo
//
//  Created by Kadir Yılmaz on 5.03.2023.
//

import Foundation

class User {
    
    var userId: String?
    var userName: String?
    var userScore: Int?
    
    init(userId: String? = nil, userName: String? = nil, userScore: Int? = nil) {
        self.userId = userId
        self.userName = userName
        self.userScore = userScore
    }
    
    init(){
        
    }
}
