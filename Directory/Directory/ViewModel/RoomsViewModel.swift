//
//  RoomsViewModel.swift
//  Directory
//
//  Created by Kesh Gurung on 05/09/2022.
//

import Foundation

protocol RoomsViewModelCore {
    func bind(updateHandler: @escaping () -> Void)
    func getRooms()
}

protocol RoomsViewModalAttributes {
    var count: Int {get}
    func createdAt (for index: Int) -> String?
    func isOccupied (for index: Int) -> Bool?
    func maxOccupancy (for index: Int) -> Int?
    func id (for index: Int) -> String?
   
}

class RoomsViewModel {
    
    private var rooms: [RoomsPage] = [] {
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

extension RoomsViewModel: RoomsViewModelCore {
    func bind(updateHandler: @escaping () -> Void) {
        self.updateHandler = updateHandler
    }
    
    func getRooms() {
        
        self.networkManager.getData(url: NetworkParams.rooms.url){ (result: Result<[RoomsPage], NetworkError>) in
            switch result {
            case .success(let page):
                self.rooms.append(contentsOf: page)
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension RoomsViewModel: RoomsViewModalAttributes {
    var count: Int {
        return self.rooms.count
    }
    
    func createdAt(for index: Int) -> String? {
        guard index < self.count else {return nil}
        return self.rooms[index].createdAt
    }
    
    func isOccupied(for index: Int) -> Bool? {
        guard index < self.count else {return nil}
        return self.rooms[index].isOccupied
    }
    
    func maxOccupancy(for index: Int) -> Int? {
        guard index < self.count else {return nil}
        return self.rooms[index].maxOccupancy
    }
    
    func id(for index: Int) -> String? {
        guard index < self.count else {return nil}
        return self.rooms[index].id
    }
    
    
}
