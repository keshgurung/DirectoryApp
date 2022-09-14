//
//  PeoplePage.swift
//  Directory
//
//  Created by Kesh Gurung on 02/09/2022.
//

import Foundation

struct PeoplePage: Decodable {
    let createdAt: String
    let firstName: String
    let avatar: String
    let lastName: String
    let email: String
    let jobTitle: String
    let favouriteColor: String
    let id: String
    
    enum CodingKeys: String, CodingKey {
        case jobTitle = "jobtitle"
        case createdAt, firstName, avatar, lastName, email, favouriteColor, id
    }
}
