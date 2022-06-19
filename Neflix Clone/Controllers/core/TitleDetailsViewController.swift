//
//  TitleDetailsViewController.swift
//  Neflix Clone
//
//  Created by mohamed salah on 18/06/2022.
//

import UIKit
import WebKit
class TitleDetailsViewController: UIViewController {
    
    
    let webView : WKWebView = {
        let wkView = WKWebView()
        wkView.translatesAutoresizingMaskIntoConstraints = false
        return wkView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .green

        view.addSubview(webView)
        // Do any additional setup after loading the view.
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
    }

    func configureData(videoURL : String){
        guard let url = URL(string: "https://www.youtube.com/embed/\(videoURL)") else{return}
        webView.load(URLRequest(url: url))
    }
}
