//
//  RoomsPage.swift
//  Directory
//
//  Created by Kesh Gurung on 02/09/2022.
//

import Foundation

struct RoomsPage: Decodable {
    let createdAt: String
    let isOccupied: Bool
    let maxOccupancy: Int
    let id: String
}
