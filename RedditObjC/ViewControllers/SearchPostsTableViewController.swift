//
//  SearchPostsTableViewController.swift
//  RedditObjC
//
//  Created by Ben Huggins on 2/13/19.
//  Copyright © 2019 User. All rights reserved.
//

import UIKit

class SearchPostsTableViewController: UITableViewController, UISearchBarDelegate {

    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var posts: [BHPost] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    searchBar.delegate = self
        BHredditController.shared().searchForPost(withSearchTerm: "Funny") { (posts, error) in
            self.posts = posts
         
            
        }
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) { 
        guard let searchText = searchBar.text else {return}
       
      
        BHredditController.shared().searchForPost(withSearchTerm: searchText) { (posts, error) in
            
            self.posts = posts
            DispatchQueue.main.async {
                 self.title = searchText
            }


        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return posts.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as? PostTableViewCell else {return   UITableViewCell() }

       let post = posts[indexPath.row]
        cell.post = post
        
        
        BHredditController.shared().fethImagePost(post) { (image) in
            DispatchQueue.main.async {
                cell.thumbnail = image
            }
        }
        
        return cell
    }
    
}
