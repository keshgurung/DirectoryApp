//
//  MainCoordinator.swift
//  Directory
//
//  Created by Kesh Gurung on 08/09/2022.
//

import Foundation
import UIKit

protocol PeopleCoordinator {
    func navigateDetails(people: PeoplePage)
}

class MainCoordinator: Coordinator {
    var navigationController: UINavigationController?
    
    
    let window: UIWindow
//    var navigationController: UINavigationController?
    
    init(window: UIWindow){
        self.window = window
    }
    
   
    
    func start() {
        window.rootViewController = MainViewController()
    }
    
   
}

extension MainCoordinator: PeopleCoordinator {
    func navigateDetails(people: PeoplePage) {
//        let peopleDetailsVM = 
    }
    
    
}
