//
//  UIViewExtension.swift
//  Directory
//
//  Created by Kesh Gurung on 05/09/2022.
//

import UIKit


extension UIView {
    
    func bindToSuperView(insets: UIEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)) {
        
        
        guard let superSafeArea = self.superview?.safeAreaLayoutGuide else {
            fatalError("error in extension bind view")
        }
        
        self.topAnchor.constraint(equalTo: superSafeArea.topAnchor, constant: insets.top).isActive = true
        self.leadingAnchor.constraint(equalTo: superSafeArea.leadingAnchor, constant: insets.left).isActive = true
        self.trailingAnchor.constraint(equalTo: superSafeArea.trailingAnchor, constant: -insets.right).isActive = true
        self.bottomAnchor.constraint(equalTo: superSafeArea.bottomAnchor, constant: -insets.bottom).isActive = true
    }
    
    
}


