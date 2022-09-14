//
//  NetworkService.swift
//  Directory
//
//  Created by Kesh Gurung on 02/09/2022.
//

import Foundation

protocol NetworkService {
    func getData<T: Decodable>(url: URL?, completion: @escaping (Result<[T], NetworkError>) -> Void)
    func getImage(url: String?, completion: @escaping (Result<Data, NetworkError>) -> Void)
}


class NetworkManager {
    
    let session: Session
    let decoder: JSONDecoder = JSONDecoder()
    
    init(session: Session = URLSession.shared) {
        self.session = session
    }
    
}

extension NetworkManager: NetworkService {
    
    func getData<T>(url: URL?, completion: @escaping (Result<[T], NetworkError>) -> Void) where T : Decodable {
        guard let url = url else {
            completion(.failure(NetworkError.urlFailure))
            return
        }
        
        self.session.retrieveData(url: url) { data, response, error in
            
            if let error = error {
                completion(.failure(NetworkError.other(error)))
                return
            }
            if let hResponse = response as? HTTPURLResponse, !(200..<300).contains(hResponse.statusCode) {
                completion(.failure(NetworkError.serverResponse(hResponse.statusCode)))
                return
            }
            guard let data = data else {
                completion(.failure(NetworkError.dataFailure))
                return
            }
            
            do {
                let model = try self.decoder.decode([T].self, from: data)
                completion(.success(model))
            } catch {
                completion(.failure(NetworkError.decodeError(error)))
            }
        }
    }
    
    func getImage(url: String?, completion: @escaping (Result<Data, NetworkError>) -> Void) {

        guard let url = URL(string: url ?? "none") else {
            completion(.failure(NetworkError.urlFailure))
            return
        }
        
        self.session.retrieveData(url: url) { data, response, error in
            
            if let error = error {
                completion(.failure(NetworkError.other(error)))
                return
            }
            
            if let hResponse = response as? HTTPURLResponse, !(200..<300).contains(hResponse.statusCode) {
                completion(.failure(NetworkError.serverResponse(hResponse.statusCode)))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.dataFailure))
                return
            }
            
            completion(.success(data))
            
        }
        
        
    }
    
}
    
