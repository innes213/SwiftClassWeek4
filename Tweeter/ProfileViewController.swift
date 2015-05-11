//
//  ProfileViewController.swift
//  Tweeter
//
//  Created by Rob Hislop on 5/9/15.
//  Copyright (c) 2015 Rob Hislop. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tweetCountLabel: UILabel!
    @IBOutlet weak var followerCountLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    
    var user: User! {
        didSet{
            profileImageView.setImageWithURL(user.profileImageUrl)
            nameLabel.text = user.name
            tweetCountLabel.text = "\(user.tweetCount) tweets"
            followerCountLabel.text = "\(user.followerCount) followers"
            followingCountLabel.text = "\(user.followingCount) following"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
