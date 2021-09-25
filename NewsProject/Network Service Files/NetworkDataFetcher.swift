//
//  NetworkDataFetcher.swift
//  NewsProject
//
//  Created by Natallia Askerka on 25.08.21.
//

import Foundation

protocol DataFetcher {
    func genericJSONDataWith<T: Decodable>(type: NetworkService.RequestType, urlString: String, parameters: [String : Any], response: @escaping (T?) -> Void)
}

class NetworkDataFetcher: DataFetcher {
    var networking: Networking
    
    init(networking: Networking = NetworkService()) {
        self.networking = networking
    }
    
    func genericJSONDataWith<T: Decodable>(type: NetworkService.RequestType,
                                           urlString: String,
                                           parameters: [String : Any],
                                           response: @escaping (T?) -> Void) {
       
        networking.request(type: .GET ,urlString: urlString, parameters: parameters) { (data, resp, error) in
            if let error = error {
                print("Error received requesting data: \(error.localizedDescription)")
                response(nil)
            }
            let decoded = self.decodeJSON(type: T.self, from: data)
            response(decoded)
        }
    }
        
    func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = from else { return nil }
        
        do {
            let objects = try decoder.decode(type.self, from: data)
            return objects
        } catch let jsonError {
            print("Failed to decode JSON", jsonError)
            return nil
        }
    }
}
