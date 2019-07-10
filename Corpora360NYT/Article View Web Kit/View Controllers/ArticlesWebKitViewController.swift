//
//  ArtiiclesWebKitViewController.swift
//  Corpora360NYT
//
//  Created by Juan Carlos Merlos Albarracín on 09/07/2019.
//  Copyright © 2019 devspain. All rights reserved.
//

import UIKit
import WebKit

class ArticlesWebKitViewController: UIViewController {
    
    @IBOutlet weak var articleDetailLabel: UILabel!
    @IBOutlet weak var articleDetailWebView: WKWebView!
    @IBOutlet weak var activityIndWebView: UIActivityIndicatorView!
    
    var webView: WKWebView!
    var popupWebView: WKWebView?
    var articleTitle: String?
    var urlArticle: String?
    var activityIndicator: UIActivityIndicatorView!
    
    private var loadingObservation: NSKeyValueObservation?
    
    private lazy var loadingIndicator: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.style = UIActivityIndicatorView.Style.whiteLarge
        spinner.color = .black
        return spinner
    }()
    
    override func loadView() {
        super.loadView()
        webView = WKWebView()
        webView.uiDelegate = self
        webView.navigationDelegate = self
        view = webView
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setActivityIndicator()
        setupWebView()
        
    }
    
    // MARK: - Setup Web View
    
    func setupWebView() {
        
        let preferences = WKPreferences()
        preferences.javaScriptEnabled = true
        preferences.javaScriptCanOpenWindowsAutomatically = true
        
        let configuration = WKWebViewConfiguration()
        configuration.preferences = preferences
        
        setTitle(articleTitle ?? "NY Times Article")
        if let url = URL(string: urlArticle ?? "https://www.nytimes.com/") {
            let request = URLRequest(url: url)
            webView.load(request)
        }
        webView.allowsBackForwardNavigationGestures = true
        
    }
    
    // MARK: - Setup Activity Indicator
    
    func setActivityIndicator() {
        
        loadingObservation = webView.observe(\.isLoading, options: [.new, .old]) { [weak self] (_, change) in
            guard let strongSelf = self else { return }
            
            let new = change.newValue!
            let old = change.oldValue!
            
            if new && !old {
                strongSelf.view.addSubview(strongSelf.loadingIndicator)
                strongSelf.loadingIndicator.startAnimating()
                NSLayoutConstraint.activate([strongSelf.loadingIndicator.centerXAnchor.constraint(equalTo: strongSelf.view.centerXAnchor),
                                             strongSelf.loadingIndicator.centerYAnchor.constraint(equalTo: strongSelf.view.centerYAnchor)])
                strongSelf.view.bringSubviewToFront(strongSelf.loadingIndicator)
            }
            else if !new && old {
                strongSelf.loadingIndicator.stopAnimating()
                strongSelf.loadingIndicator.removeFromSuperview()
            }
        }
    }
    
}

// MARK: Extensions - Load URL & Delegates Web View -

extension ArticlesWebKitViewController: WKNavigationDelegate {
    
    open func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    func webView(_ webView: WKWebView, didFailLoadWithError error: Error) {
        print("webview did fail load with error: \(error)")
        
        let message = error.localizedDescription
        
        let alert = UIAlertController(title: "Error loading page", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default) { action in
            self.navigationController?.popViewController(animated: true)
        })
        self.present(alert, animated: true)
    }
    
}

extension ArticlesWebKitViewController: WKUIDelegate {
    
    
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction:
        WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        popupWebView = WKWebView(frame: view.bounds, configuration: configuration)
        popupWebView!.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        popupWebView!.navigationDelegate = self
        popupWebView!.uiDelegate = self
        view.addSubview(popupWebView!)
        return popupWebView!
    }
    
    func webViewDidClose(_ webView: WKWebView) {
        if webView == popupWebView {
            popupWebView?.removeFromSuperview()
            popupWebView = nil
        }
    }
    
}

extension ArticlesWebKitViewController {
    
    func load(_ urlString: String) {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            load(request.description)
        }
    }
}
