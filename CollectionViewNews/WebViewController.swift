//
//  WebViewController.swift
//  News
//
//  Created by Duc Tran on 7/21/15.
//  Copyright © 2015 Developer Inspirus. All rights reserved.
//

import UIKit

class WebViewController: UIViewController, UIWebViewDelegate
{
    
    var publisher: Publisher!
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet private weak var webView: UIWebView!
    
    private var hasFinishLoading = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = publisher.title
        webView.delegate = self
        webView.stopLoading()
        let pageURL = NSURL(string: publisher.url)!
        let request = NSURLRequest(URL: pageURL)
        webView.loadRequest(request)
        // navigationController?.hidesBarsOnSwipe = true
    }
    
    
    func webViewDidStartLoad(webView: UIWebView) {
        hasFinishLoading = false
        updateProgress()
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(1.0 * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) {
            [weak self] in
            if let _self = self {
                _self.hasFinishLoading = true
            }
        }
    }
    
    deinit {
        webView.stopLoading()
        webView.delegate = nil
    }
    
    func updateProgress() {
        if progressBar.progress >= 1 {
            progressBar.hidden = true
        } else {
            
            if hasFinishLoading {
                progressBar.progress += 0.002
            } else {
                if progressBar.progress <= 0.3 {
                    progressBar.progress += 0.004
                } else if progressBar.progress <= 0.6 {
                    progressBar.progress += 0.002
                } else if progressBar.progress <= 0.9 {
                    progressBar.progress += 0.001
                } else if progressBar.progress <= 0.94 {
                    progressBar.progress += 0.0001
                } else {
                    progressBar.progress = 0.9401
                }
            }
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(0.008 * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) {
                [weak self] in
                if let _self = self {
                    _self.updateProgress()
                }
            }
        }
    }
    
    
}
