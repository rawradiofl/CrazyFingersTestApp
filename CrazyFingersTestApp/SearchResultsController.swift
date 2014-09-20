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
    
    var api: SubSonicAPIControllerProtocol?
    var kCellIdentifier: String = "SearchResultsCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func didReceiveAPIResults(results: NSDictionary) {
        var resultsArr: NSArray = results["results"] as NSArray
        dispatch_async(dispatch_get_main_queue(), {
            //no-op for now
        })
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier(kCellIdentifier) as UITableViewCell
        cell.textLabel?.text = "Hi There!!"
        cell.detailTextLabel?.text = "details here please"
        return cell
    }

}

