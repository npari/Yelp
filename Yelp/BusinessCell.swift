//
//  BusinessCell.swift
//  Yelp
//
//  Created by Pari, Nithya on 4/8/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit
import AFNetworking

class BusinessCell: UITableViewCell {

    @IBOutlet weak var businessNameLabel: UILabel!
    @IBOutlet weak var businessImageView: UIImageView!
    @IBOutlet weak var businessRatingImageView: UIImageView!
    @IBOutlet weak var businessRatingLabel: UILabel!
    @IBOutlet weak var businessAddressLabel: UILabel!
    @IBOutlet weak var businessCategoriesLabel: UILabel!
    @IBOutlet weak var businessDistanceLabel: UILabel!
    
    //Variable with observer
    var business: Business! {
        didSet {
            businessNameLabel.text = business.name
            businessAddressLabel.text = business.address
            businessImageView.setImageWith(business.imageURL!)
            businessCategoriesLabel.text = business.categories
            businessDistanceLabel.text="\(business.distance!)"
            businessRatingImageView.setImageWith(business.ratingImageURL!)
            businessRatingLabel.text = "\(business.reviewCount!)Reviews"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        businessImageView.layer.cornerRadius = 3
        businessImageView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
