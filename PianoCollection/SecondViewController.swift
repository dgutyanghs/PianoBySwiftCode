//
//  SecondViewController.swift
//  PianoCollection
//
//  Created by  BlueYang on 17/2/11.
//  Copyright © 2017年  BlueYang. All rights reserved.
//

import UIKit
import WebKit

class SecondViewController: UIViewController, WKNavigationDelegate  {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let webView = WKWebView.init(frame: view.frame)
        view .addSubview(webView)
        webView.navigationDelegate = self
        if let url = URL.init(string: "https://120.25.207.78/videos/demo.mp4") {
//        if let url = URL.init(string: "https://media.w3.org/2010/05/sintel/trailer.mp4") {
//            let request = URLRequest.init(url: url)
            let request = URLRequest.init(url: url, cachePolicy: URLRequest.CachePolicy.useProtocolCachePolicy, timeoutInterval:10)
            
            webView.load(request)
        }
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("start to load urlrequest")
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print("recevice data")
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
//        if error != nil {
           print("webview load error value:\(error.localizedDescription)")
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

}

