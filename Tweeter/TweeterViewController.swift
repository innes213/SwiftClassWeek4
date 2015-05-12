//
//  TweeterViewController.swift
//  Tweeter
//
//  Created by Rob Hislop on 5/10/15.
//  Copyright (c) 2015 Rob Hislop. All rights reserved.
//

import UIKit

class TweeterViewController: UIViewController {
    
    var viewOnCenter: CGPoint!
    var viewRightCenter: CGPoint!
    var delegate: TweetsViewControllerDelegate?
    
    @IBAction func viewPanGesture(sender: UIPanGestureRecognizer) {
        var point = sender.locationInView(view)
        var velocity = sender.velocityInView(view)
        
        if sender.state == UIGestureRecognizerState.Began {
            println("Gesture began at: \(point)")
        } else if sender.state == UIGestureRecognizerState.Changed {
            println("Gesture changed at: \(point)")
        } else if sender.state == UIGestureRecognizerState.Ended {
            println("Gesture ended at: \(point)")
            if (velocity.x > 0) {
                view.center = viewRightCenter
            } else {
                view.center = viewOnCenter
            }
        }
        
    }
    
    @IBAction func profileImageTap(sender: UITapGestureRecognizer) {
        println("image tapped")
        println("\(sender.description)")
        performSegueWithIdentifier("viewProfileSegue", sender: self)
    }

    var tweetsViewController: TweetsViewController!
    var tweetsNavigationController: UINavigationController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        println("TweeterViewController:viewDidLoad")
        
        tweetsViewController = UIStoryboard.tweetsViewController()
        tweetsViewController.delegate = self
        
        // wrap the centerViewController in a navigation controller, so we can push views to it
        // and display bar button items in the navigation bar
        tweetsNavigationController = UINavigationController(rootViewController: tweetsViewController)
        view.addSubview(tweetsNavigationController.view)
        addChildViewController(tweetsNavigationController)
        
        tweetsNavigationController.didMoveToParentViewController(self)
        
        viewOnCenter = view.center
        viewRightCenter = viewOnCenter
        viewRightCenter.x = viewOnCenter.x + 200
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
        
        if (segue.identifier == "viewProfileSegue") {
            println("segue to view profile")
            if let cell = sender as? UITableViewCell {
                let indexPath = tableView.indexPathForCell(cell)
                let user = tweets![indexPath!.row].user
                let profileViewController = segue.destinationViewController as! ProfileViewController
                profileViewController.user = user
                println("\(user)")
            }
        } else {
            if let cell = sender as? UITableViewCell {
                let indexPath = tableView.indexPathForCell(cell)!
                let tweet = tweets![indexPath.row]
                let tweetViewController = segue.destinationViewController as! TweetViewController
                
                tweetViewController.tweet = tweet
            }
        }
    }
    
 */

}

// MARK: TweeterViewController delegate

extension TweeterViewController: TweetsViewControllerDelegate {
    
    func toggleProfileView() {
    }
    
    func toggleMentionsView() {
    }
    
    func addProfileViewController() {
    }
    
    func addMentionsViewController() {
    }
    
    func animateProfileView(#shouldExpand: Bool) {
    }
    
    func animateMentionsView(#shouldExpand: Bool) {
    }
}

private extension UIStoryboard {
    class func mainStoryboard() -> UIStoryboard { return UIStoryboard(name: "Main", bundle: NSBundle.mainBundle()) }
    
    class func profileViewController() -> ProfileViewController? {
        return mainStoryboard().instantiateViewControllerWithIdentifier("profileViewController") as? ProfileViewController
    }
    
    class func mentionsViewController() -> MentionsViewController? {
        return mainStoryboard().instantiateViewControllerWithIdentifier("mentionsViewController") as? MentionsViewController
    }
    
    class func tweetsViewController() -> TweetsViewController? {
        return mainStoryboard().instantiateViewControllerWithIdentifier("tweetsViewController") as? TweetsViewController
    }
    
}
