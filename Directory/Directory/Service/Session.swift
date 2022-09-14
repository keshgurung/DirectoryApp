//
//  Session.swift
//  Directory
//
//  Created by Kesh Gurung on 12/09/2022.
//

import Foundation

protocol Session {
    func retrieveData(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void)
}

extension URLSession: Session {
    
    func retrieveData(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        self.dataTask(with: url) { data, response, error in
            completion(data, response, error)
        }.resume()
    }
    
}
