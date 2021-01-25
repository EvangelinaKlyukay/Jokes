//
//  Jokes.swift
//  Jokes
//
//  Created by Евангелина Клюкай on 20.01.2021.
//

import Foundation

class Joke: NSObject {
    
    let id: String
    let text: String
    
    init(data: [String: Any]) {
        self.id = data["id"] as? String ?? ""
        self.text = data["joke"] as? String ?? ""
    }
}
