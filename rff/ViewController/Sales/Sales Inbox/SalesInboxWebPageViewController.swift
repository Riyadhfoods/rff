//
//  SalesInboxWebPageViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 06/06/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit
import WebKit

class SalesInboxWebPageViewController: UIViewController {

    var urlString: String = ""
    let ExpTime = TimeInterval(60 * 60 * 24 * 365)
    
    @IBOutlet weak var salesInboxWebView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("url string is \(urlString)")
        
        if let url = URL(string: urlString), let userId = AuthServices.currentUserId{
            let cookieStorage = HTTPCookieStorage.shared
            let cookieHeaderField = ["Set-Cookie": "empNo=" + userId + ";"]
            let cookie = HTTPCookie.cookies(withResponseHeaderFields: cookieHeaderField, for: url)
            cookieStorage.setCookies(cookie, for: url, mainDocumentURL: nil)
            
            let request = NSMutableURLRequest(url: url)
            request.setValue("empNo=" + userId, forHTTPHeaderField: "Cookie")
            
            salesInboxWebView.load(request as URLRequest)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setCookie(key: String, value: AnyObject) {
        let cookieProps: [HTTPCookiePropertyKey : Any] = [
            HTTPCookiePropertyKey.domain: urlString,
            HTTPCookiePropertyKey.path: "/",
            HTTPCookiePropertyKey.name: key,
            HTTPCookiePropertyKey.value: value,
            HTTPCookiePropertyKey.secure: "TRUE",
            HTTPCookiePropertyKey.expires: NSDate(timeIntervalSinceNow: ExpTime)
        ]
        
        if let cookie = HTTPCookie(properties: cookieProps) {
            HTTPCookieStorage.shared.setCookie(cookie)
        }
    }

}
