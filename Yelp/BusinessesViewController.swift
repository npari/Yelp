//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, FiltersViewControllerDelegate {
    
    @IBOutlet weak var businessTableView: UITableView!
    var businesses: [Business]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        businessTableView.delegate = self
        businessTableView.dataSource = self
        
        //Direct to use autolayout constraints
        businessTableView.rowHeight = UITableViewAutomaticDimension
        businessTableView.estimatedRowHeight = 120
        
        //By default, we display the restaurants in the feeds page
        Business.searchWithTerm(term: "Restaurants", completion: { (businesses: [Business]?, error: Error?) -> Void in
            
            self.businesses = businesses
            self.businessTableView.reloadData()
            
            //Logging the data
            if let businesses = businesses {
                for business in businesses {
                    print(business.name!)
                    print(business.address!)
                }
            }
            }
        )
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if businesses != nil {
            return businesses.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let businessCell = businessTableView.dequeueReusableCell(withIdentifier: "BusinessCell", for: indexPath) as! BusinessCell
        businessCell.business = businesses[indexPath.row]
        
        return businessCell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        let filtersViewController = navigationController.topViewController as! FiltersViewController
        filtersViewController.delegate = self
    }
        
    //Delegate method implementation
    func filtersViewController(filtersViewController: FiltersViewController, didUpdateFilters filters: [String : AnyObject]) {
        
        let categories = filters["categories"] as? [String]
        let sort = filters["sort"] as? YelpSortMode
//        let distance = filters["distance"] as? Int
        let deals = filters["deals"] as? Bool
        
        Business.searchWithTerm(term: "Restaurants",
                                sort: sort,
                                categories: categories,
                                deals: deals,
                                completion: ({businesses, error -> Void in
                                    self.businesses = businesses
                                    self.businessTableView.reloadData()
                                }))
    }
}
