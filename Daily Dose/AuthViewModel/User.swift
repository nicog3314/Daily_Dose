//
//  User.swift
//  Daily Dose
//
//  Created by Nicole Gonzalez on 2/13/24.
//

import Foundation


struct User: Identifiable, Codable{
    
    
    //all constants, other than useID
    var id: String 
    let first:String
    let last:String
    let email: String
    
    
}
extension User{
    static var MOCK_USER = User(id: NSUUID().uuidString , first: "Nicole", last: "Gonzalez", email: "ngonzalez@gmail.com")
}

