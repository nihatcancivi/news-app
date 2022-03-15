//
//  WebViewController.swift
//  NewsApp
//
//  Created by Nihat on 13.03.2022.
//

import UIKit
import WebKit

class WebViewController: UIViewController , WKUIDelegate {
    var webView: WKWebView!
    var newsUrl : String?
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
      
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if let myURL = URL(string: newsUrl!){
            let myRequest = URLRequest(url: myURL)
            webView.load(myRequest)
        }
    }
}

