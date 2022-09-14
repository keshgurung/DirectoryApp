//
//  NetworkParams.swift
//  Directory
//
//  Created by Kesh Gurung on 02/09/2022.
//

import Foundation

enum NetworkParams {
    
    private struct NetworkConstants {
        static let people = "https://61e947967bc0550017bc61bf.mockapi.io/api/v1/people"
        static let room = "https://61e947967bc0550017bc61bf.mockapi.io/api/v1/rooms"
//        static let  image = ""
       
    }
    
    
    case people
    case rooms
//    case peopleImage(String)
    
    var url: URL? {
        switch self {
            
        case .people:
            return URL(string: NetworkConstants.people)
            
            
        case .rooms:
            return URL(string: NetworkConstants.room)
        }
    }
    
}
