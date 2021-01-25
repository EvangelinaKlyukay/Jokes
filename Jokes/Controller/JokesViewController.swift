//
//  ViewController.swift
//  Jokes
//
//  Created by Евангелина Клюкай on 20.01.2021.
//

import UIKit

class JokesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var numberOfJokesTextField: UITextField!
    @IBOutlet private weak var loadButton: UIButton!
    @IBOutlet private weak var bottomConstraint: NSLayoutConstraint!
    
    
    private var jokes: [Joke] = []
    private let network = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillChangeFrame(_:)),
            name: UIResponder.keyboardWillChangeFrameNotification,
            object: nil
        )

    }
    
    @IBAction func loadButton(_ sender: Any) {
        
        view.endEditing(true)
        
        if let text = numberOfJokesTextField.text {
            guard let count = Int(text) else { return }
            if count >= 0, count <= 753 {
                network.getJokes(count: count) { [weak self] (jokes) in
                    self?.jokes = jokes
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    } 
                } onFail: { (error) in
                    print(error)
                }
            } else {
                let ac = UIAlertController(title: "Input number from 1 to 753", message: nil, preferredStyle: .alert)
                let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
                ac.addAction(ok)
                present(ac, animated: true, completion: nil)
            }
        }
        numberOfJokesTextField.text = nil
    }
    
    @objc func keyboardWillChangeFrame(_ notification: Notification) {
        guard
            let nsRect = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
            let nsDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber
        else {
            return
        }
        
        let endFrame = nsRect.cgRectValue
        if endFrame.origin.y >= self.view.bounds.height {
            bottomConstraint.constant = 0
        } else {
            bottomConstraint.constant = -endFrame.height
        }
        
        UIView.animate(withDuration: nsDuration.doubleValue, animations: self.view.layoutIfNeeded)
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jokes.count
    }
    
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "JokesCell", for: indexPath)
        (cell as? JokesTableViewCell)?.joke = jokes[indexPath.row]
        return cell
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
