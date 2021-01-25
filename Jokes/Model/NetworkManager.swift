//
//  NetworkManager.swift
//  Jokes
//
//  Created by Евангелина Клюкай on 20.01.2021.
//

import Foundation
import Alamofire

class NetworkManager {
    
    func getJokes(count: Int, completion: @escaping ([Joke]?) -> Void) {
        
        AF.request("http://api.icndb.com/jokes/random/\(count)?firstName=Chuck&lastName=Norris").responseJSON { response in
            guard let json = response.result as? [String: AnyObject], let jokesRawData = json["value"] as? [[String: AnyObject]] else {
                switch response.result {
                                case .success:
                                    
                                case .failure(let error):
                                    print(error)
                                }

                completion(nil)
                return
            }

            var jokes: [Joke] = []
            for rawJoke in jokesRawData {
                let joke = Joke(data: rawJoke)
                jokes.append(joke)
            }
            completion(jokes)
            
            if let error = response.error {
                print(error.localizedDescription)
            }
        }
    }
}
