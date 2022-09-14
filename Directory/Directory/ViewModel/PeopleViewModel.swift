//
//  PeopleViewModel.swift
//  Directory
//
//  Created by Kesh Gurung on 06/09/2022.

import Foundation

protocol PeopleViewModelCore {
    func bind(updateHandler: @escaping () -> Void)
    func getPeople()
}

protocol PeopleViewModalAttributes {
    var count: Int {get}
    func firstName (for index: Int) -> String?
    func lastName (for index: Int) -> String?
    func email (for index: Int) -> String?
    func jobTitle (for index: Int) -> String?
    func id (for index: Int) -> String?
    func peopleImage(for index: Int, completion: @escaping (Data?) -> Void)
}

class PeopleViewModel {
    
    private var people: [PeoplePage] = [] {
        didSet{
            self.updateHandler?()
        }
    }
    
    private var networkManager: NetworkService
    private var updateHandler: (() -> Void)?
    
    init(networkManager: NetworkService) {
        self.networkManager = networkManager
    }
    
    
}

extension PeopleViewModel: PeopleViewModelCore {
    func bind(updateHandler: @escaping () -> Void) {
        self.updateHandler = updateHandler
    }
    
    func getPeople() {
        
        self.networkManager.getData(url: NetworkParams.people.url){ (result: Result<[PeoplePage], NetworkError>) in
            switch result {
            case .success(let page):
                self.people.append(contentsOf: page)
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension PeopleViewModel: PeopleViewModalAttributes {
    var count: Int {
        return self.people.count
    }
    
    func firstName(for index: Int) -> String? {
        return self.people[index].firstName
    }
    
    func lastName(for index: Int) -> String? {
        return self.people[index].lastName
    }
    
    func email(for index: Int) -> String? {
        return self.people[index].email
    }
    
    func jobTitle(for index: Int) -> String? {
        return self.people[index].jobTitle
    }
    
    func id(for index: Int) -> String? {
        return self.people[index].id
    }
    
    func peopleImage(for index: Int, completion: @escaping (Data?) -> Void) {
        guard index < self.count else {
            completion(nil)
            return
        }
        let avatar = self.people[index].avatar
        
        // Check ImageCache
        if let imageData = ImageCache.shared.getImageData(key: avatar) {
            completion(imageData)
            return
        }
      
        // Else call network
        self.networkManager.getImage(url: avatar) { result in
            switch result {
            case .success(let imageData):
                ImageCache.shared.setImageData(data: imageData, key: avatar)
                completion(imageData)
            case .failure(let error):
                print(error)
            }
        }
    }
}
