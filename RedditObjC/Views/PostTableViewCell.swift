//
//  PostTableViewCell.swift
//  RedditObjC
//
//  Created by Ben Huggins on 2/13/19.
//  Copyright © 2019 User. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var urlLabel: UILabel!
    @IBOutlet weak var subredditLabel: UILabel!
    
    
    var post: BHPost? {
        didSet {
            updateViews()
            
        }
    }
    
    var thumbnail: UIImage? {
        didSet {
           updateViews()
        }
    }
    
    func updateViews() {
        guard let post = post else {return}
        titleLabel.text = post.title
        urlLabel.text = post.url
        subredditLabel.text = post.subreddit
        postImageView.image = thumbnail
         
        
        
        
        
    }

}
