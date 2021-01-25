//
//  JokesTableViewCell.swift
//  Jokes
//
//  Created by Евангелина Клюкай on 21.01.2021.
//

import UIKit

class JokesTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var jokesLabel: UILabel!
    
    var joke: Joke? {
        didSet {
            jokesLabel.text = joke?.text
        }
    }
}
