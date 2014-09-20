//
//  SearchResultsController.swift
//  CrazyFingersTestApp
//
//  Created by Scott Martin on 9/19/14.
//  Copyright (c) 2014 Scott Martin. All rights reserved.
//

import UIKit

class SearchResultsController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, SubSonicAPIControllerProtocol {
    @IBOutlet weak var searchResultsTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var api: SubSonicAPIController?
    var kCellIdentifier: String = "SearchResultsCell"
    var albums = [Album]()

    override func viewDidLoad() {
        super.viewDidLoad()
        api = SubSonicAPIController(delegate: self, user: "guest", passwd: "guest420", appName: "TestApp", base: nil)
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        //api?.search3("Crazy Fingers")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func didReceiveAPIResults(results: NSDictionary) {
        let response: NSDictionary = results["subsonic-response"] as NSDictionary
        let status: String = response["status"] as String
        if status != "ok" {
            println("There was an issue with the results: remote server returned status:\(status)")
        }
        println(status)
        let searchResult: NSDictionary = response["searchResult3"] as NSDictionary
        var resultsArr: NSArray = searchResult["album"] as NSArray
        dispatch_async(dispatch_get_main_queue(), {
            self.albums = Album.albumsWithJSON(resultsArr)
            self.searchResultsTableView.reloadData()
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        })
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.albums.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier(kCellIdentifier) as UITableViewCell
        let album = self.albums[indexPath.row]
        cell.textLabel?.text = album.name
        cell.detailTextLabel?.text = album.artist
        return cell
    }

    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        if let searchTerm: String = searchBar.text {
            api?.search3(searchTerm)
        }
        self.searchBar.resignFirstResponder()
    }
}

