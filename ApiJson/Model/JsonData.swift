//
//  JsonData.swift
//  ApiJson
//
//  Created by Tanmay Deo on 05/09/22.
//

import Foundation

struct JsonData : Codable{
    var users : [Users]
}

struct Users : Codable{
    var firstName : String
    var lastName : String
    var maidenName : String
    var email : String
    var image : String
}
