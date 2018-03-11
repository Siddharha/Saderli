//
//  WebViewController.swift
//  Saderli
//
//  Created by Siddhartha Maji on 16/02/18.
//  Copyright © 2018 Siddhartha Maji. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {
    @IBOutlet weak var webviewBanner: WKWebView!
    var activityIndicator:UIActivityIndicatorView!
    @IBOutlet weak var webview: WKWebView!
    var pagesLoaded:Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()    //Initialized veriables
        
       
        // Do any additional setup after loading the view.
    }
    
    func initialize() {
        pagesLoaded = 0
        webview.navigationDelegate = self
        webviewBanner.navigationDelegate = self
        activityIndicator = UIActivityIndicatorView()
        
        webview.tag = 1
        webviewBanner.tag = 2
        let url2 = URL(string: "http://adv.saderli.co.il/saderli_publication_banners1.html")
        let req2 = URLRequest(url: url2!)
        webviewBanner.load(req2)
    }

    override func viewDidAppear( _ animated: Bool) {
        super.viewDidAppear(animated)
        if Reachability.isConnectedToNetwork(){
            print("Internet Connection Available!")
            loadMainWebview()
            loadBannerWebview()
        }else{
            showNetworkAlert()
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadMainWebview() {
        let url = URL(string: "http://saderli.co.il")
        let req = URLRequest(url: url!)
        webview.load(req)
    
        
    }
    func loadBannerWebview() {
        Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(updateBanner), userInfo: nil, repeats: true)
    }
    
    @objc func updateBanner() {
        print("reloading Banner...")
        let url2 = URL(string: "http://adv.saderli.co.il/saderli_publication_banners1.html")
        let req2 = URLRequest(url: url2!)
        webviewBanner.load(req2)
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print(error.localizedDescription)
    }
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        
        if(webView.tag == 1){
        startLoadingIndicator()
        }
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        pagesLoaded = pagesLoaded+1
        if(pagesLoaded == 2){
        activityIndicator.stopAnimating()
        }
    }
    
    private func showNetworkAlert(){
        let alertController = UIAlertController(title: "Network Alert", message: "no Internet connection אינטרנט חיבור אין", preferredStyle: .alert)
        // Create the actions
        let okAction = UIAlertAction(title: "CLOSE", style: UIAlertActionStyle.default) {
            UIAlertAction in
            exit(0)
        }
        alertController.addAction(okAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func startLoadingIndicator() {
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        
        activityIndicator.layer.cornerRadius = 05
        activityIndicator.isOpaque = true
       activityIndicator.color = UIColor.black
        
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
}
