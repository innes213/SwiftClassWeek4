//
//  User.swift
//  Twitter
//
//  Created by Rob Hislop on 5/2/15.
//  Copyright (c) 2015 Rob Hislop. All rights reserved.
//

import UIKit

var _currentUser: User?
let currentUserKey = "kCurrentUser"
let userDidLoginNotification = "userDidLoginNotification"
let userDidLogoutNotification = "userDidLogoutNotification"


class User: NSObject {
    var name: String?
    var screenname: String?
    var profileImageUrl: NSURL?
    var profileBGImageUrl: NSURL?
    var tagline: String?
    var tweetCount: NSInteger?
    var followerCount: NSInteger?
    var followingCount: NSInteger?
    
    var dictionary: NSDictionary?
    
    init(dictionary: NSDictionary) {
        self.dictionary = dictionary
        name = dictionary["name"] as? String
        screenname = dictionary["screen_name"] as? String
        tagline = dictionary["description"] as? String
        tweetCount = dictionary["statuses_count"] as? NSInteger
        followerCount = dictionary["followers_count"] as? NSInteger
        followingCount = dictionary["following"] as? NSInteger
        
        
        let profileImageUrlString = dictionary["profile_image_url"] as? String
        if profileImageUrlString != nil {
            profileImageUrl = NSURL(string: profileImageUrlString!)!
        } else {
            profileImageUrl = nil
        }
        
        let profileBGImageUrlString = dictionary["profile_background_image_url"] as? String
        if profileBGImageUrlString != nil {
            profileBGImageUrl = NSURL(string: profileBGImageUrlString!)!
        } else {
            profileBGImageUrl = nil
        }
        
    }
    
    func logout() {
        User.currentUser = nil
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        // Set NSNotification
        NSNotificationCenter.defaultCenter().postNotificationName(userDidLogoutNotification, object: nil)
    }
    
    class var currentUser: User? {
        get {
            if _currentUser == nil {
                var data = NSUserDefaults.standardUserDefaults().objectForKey(currentUserKey) as? NSData
                if data != nil {
                    var dictionary = NSJSONSerialization.JSONObjectWithData(data!, options: nil, error: nil) as? NSDictionary
                    _currentUser = User(dictionary: dictionary!)
                }
            }
            return _currentUser
        }
        set(user) {
            _currentUser = user
            //cheat by using JSON
            if _currentUser != nil {
                // save current user to NSUserDefaults
                var data = NSJSONSerialization.dataWithJSONObject(user!.dictionary!, options: nil, error: nil)
                NSUserDefaults.standardUserDefaults().setObject(data, forKey: currentUserKey)
            } else {
                // User is logging out
                NSUserDefaults.standardUserDefaults().setObject(nil, forKey: currentUserKey)
            }
            // Flush to disk
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
   
}
