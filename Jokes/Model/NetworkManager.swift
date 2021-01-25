//
//  NetworkManager.swift
//  Jokes
//
//  Created by Евангелина Клюкай on 20.01.2021.
//

import Foundation
import Alamofire

class NetworkManager {
    
    func getJokes(count: Int, completion: @escaping ([Joke]) -> Void, onFail: ((Error) -> Void)?) {
        
        AF.request("http://api.icndb.com/jokes/random/\(count)?firstName=Chuck&lastName=Norris").responseJSON { response in
            switch response.result {
            case .success(let data):
                guard let json = data as? [String: Any], let values = json["value"] as? [[String: Any]] else {
                    print("Unable to parse response")
                    return
                }
                
                let jokes = values.map({ Joke(data: $0) })
                completion(jokes)
                
            case .failure(let error):
                print(error.localizedDescription)
                onFail?(error)
            }
        }
    }
}
