//
//  Coordinator.swift
//  Directory
//
//  Created by Kesh Gurung on 08/09/2022.
//

import Foundation
import UIKit


protocol Coordinator: AnyObject {
    
    //nav controller
    var navigationController: UINavigationController? { get set}

    // start the coordinator when app launches
    func start()
}
