//
//  WKWebViewController.swift
//  Jokes
//
//  Created by Евангелина Клюкай on 21.01.2021.
//

import Foundation
import WebKit

class WKWebViewController: UIViewController {
    
    private var webView: WKWebView?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView = WKWebView(frame: view.bounds)
        view.addSubview(webView!)
        
        NSLayoutConstraint.activate([
            webView!.topAnchor.constraint(equalTo: view!.topAnchor),
            webView!.leadingAnchor.constraint(equalTo: view!.leadingAnchor),
            webView!.bottomAnchor.constraint(equalTo: view!.bottomAnchor),
            webView!.trailingAnchor.constraint(equalTo: view!.trailingAnchor)
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        webView?.loadUrl(string: "http://www.icndb.com/api/")
    }
}

extension WKWebView {
    func loadUrl(string: String) {
        if let url = URL(string: string) {
            load(URLRequest(url: url))
        }
    }
}
