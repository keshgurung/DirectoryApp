//
//  ViewController.swift
//  Directory
//
//  Created by Kesh Gurung on 02/09/2022.
//

import UIKit

class MainViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        tabBar.tintColor = .label
//        self.tabBar.backgroundColor = .systemRed
        
        let vc1 = UINavigationController(rootViewController: PeopleViewController())
        let vc2 = UINavigationController(rootViewController: RoomsViewController())
        
        vc1.tabBarItem = UITabBarItem(title: "People", image: UIImage(systemName: "person"), tag: 1)
        vc2.tabBarItem = UITabBarItem(title: "Rooms", image: UIImage(systemName: "square.split.bottomrightquarter"), tag: 1)
        
        setViewControllers([vc1, vc2], animated: true)
    }
    
}

