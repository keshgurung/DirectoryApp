//
//  MockService.swift
//  DirectoryTests
//
//  Created by Kesh Gurung on 12/09/2022.
//

import Foundation
@testable import Directory

class MockService: NetworkService {
    
    func getData<T>(url: URL?, completion: @escaping (Result<[T], NetworkError>) -> Void) where T : Decodable {
        
        guard let url = NetworkParams.people.url else {
            completion(.failure(NetworkError.urlFailure))
            return
        }
        
        let mockSession = MockSession()
        mockSession.retrieveData(url: url) { data, response, error in
            
            guard let data = data else {
                completion(.failure(NetworkError.dataFailure))
                return
            }

            do {
                let model = try JSONDecoder().decode([T].self, from: data)
                completion(.success(model))
            } catch {
                print(error)
            }
            
            
        }
        
        
        
    }
    
    func getRoomsData<T>(url: URL?, completion: @escaping (Result<[T], NetworkError>) -> Void) where T : Decodable {
        
        guard let url = NetworkParams.rooms.url else {
            completion(.failure(NetworkError.urlFailure))
            return
        }
        
        let mockSession = MockSession()
        mockSession.retrieveData(url: url) { data, response, error in
            
            guard let data = data else {
                completion(.failure(NetworkError.dataFailure))
                return
            }

            do {
                let model = try JSONDecoder().decode([T].self, from: data)
                completion(.success(model))
            } catch {
                print(error)
            }
            
            
        }
        
        
        
    }
    
    func getImage(url: String?, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        
    }
    
   
   
}
