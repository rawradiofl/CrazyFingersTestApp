//
//  SubSonicAPIController.swift
//  CrazyFingersTestApp
//
//  Created by Scott Martin on 9/19/14.
//  Copyright (c) 2014 Scott Martin. All rights reserved.
//

import Foundation

protocol SubSonicAPIControllerProtocol {
    func didReceiveAPIResults(results: NSDictionary)
}

class SubSonicAPIController {
    var delegate: SubSonicAPIControllerProtocol?
    var baseUrl: String? = "http://camelwalk.subsonic.org/rest/"
    var user: String
    var passwd: String
    var appName: String
    
    init(delegate: SubSonicAPIControllerProtocol?, user: String, passwd: String, appName: String, base: String?) {
        if let home = base {
            self.baseUrl = home
        }
        self.user = user
        self.passwd = passwd
        self.appName = appName
        self.delegate = delegate
    }
    
    func buildUrl(command: String) -> String {
        let completeUrlPath = "\(self.baseUrl!)\(command)?u=\(self.user)&p=\(self.passwd)&v=1.10.0&c=\(self.appName)&f=json"
        return completeUrlPath
    }
    
    func get(path: String) {
        let url: NSURL? = NSURL(string: path)
        
        let session = NSURLSession.sharedSession()
        if url != nil {
            let task = session.dataTaskWithURL(url!, completionHandler: {data, response, error -> Void in
                println("Task completed")
                if error != nil {
                    // There was an error with the request
                    println(error.localizedDescription)
                }
                var err: NSError?
                var jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &err) as NSDictionary
                if err != nil {
                    // There was an error while parsing the json. print to console
                    println("JSON Error: \(err?.localizedDescription)")
                }
                
                //let results: NSArray = jsonResult["subsonic-response"] as NSArray
                self.delegate?.didReceiveAPIResults(jsonResult)
            })
            task.resume()
        }
    }
    
    func search3(searchTerm: String) {
        var urlString = buildUrl("search3.view")
        var term = searchTerm.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        term = term.stringByReplacingOccurrencesOfString(" ", withString: "+", options: NSStringCompareOptions.CaseInsensitiveSearch, range: nil)
        term = term.stringByReplacingOccurrencesOfString("\"", withString: "", options: NSStringCompareOptions.CaseInsensitiveSearch, range: nil)
        let escapedTerm = term.stringByReplacingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
        urlString = urlString + "&query=\(escapedTerm!)"
        println("url string: \(urlString)")
        get(urlString)
    }
    
    func getArtists() {
        var urlString = buildUrl("getArtists.view")
        //println("artists: \(urlString)")
        get(urlString)
        
    }
    
}