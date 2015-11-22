//
//  ViewController.swift
//  Cocktails
//
//  Created by Stephen Casella on 11/21/15.
//  Copyright © 2015 Stephen Casella. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

var id = "old-fashioned"
var videoURL = "http://assets.absolutdrinks.com/videos/absolut-cosmopolitan.mp4"
var ingredientsArray = [String]()

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var drinkImg: UIImageView!
    @IBOutlet weak var shelfImg: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var instructionsLabel: UILabel!
    @IBOutlet weak var story: UILabel!
    @IBOutlet weak var showButton: UIButton!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var detailSegment: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
          super.viewDidLoad()
        detailSegment.backgroundColor = UIColor(red: 32/255, green: 36/255, blue: 66/255, alpha: 1.0)
         detailSegment.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.whiteColor()], forState: UIControlState.Normal)
        detailSegment.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.whiteColor()], forState: UIControlState.Selected)
        segmentControl.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.whiteColor()], forState: UIControlState.Normal)
         segmentControl.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.whiteColor()], forState: UIControlState.Selected)
        
       
     // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        
      
        downloadData(id, title: label, image: image, story: story, instructions: instructionsLabel, table: tableView, placeholder: drinkImg, taste: "", occasion: "", spirit: "")

    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func navBarPressed(sender: UITapGestureRecognizer) {
        if segmentControl.selectedSegmentIndex == 0 || segmentControl.selectedSegmentIndex == 1 || segmentControl.selectedSegmentIndex == 2 {
            
            setSeg = segmentControl.selectedSegmentIndex
            performSegueWithIdentifier("toNav", sender: self)
            
        }
        
        
    }
    
    
    @IBAction func showButtonPressed() {
        showButton.hidden = true
        UIView.animateWithDuration(1.5, animations: { () -> Void in
            self.image.transform.tx = -500
            self.shelfImg.transform.tx = -500
            self.drinkImg.transform.tx = -500
            self.story.alpha = 0.0
            self.image.transform.ty = +50
            self.drinkImg.transform.ty = +50
            self.shelfImg.transform.ty = +50
         
            
            }) { (Bool) -> Void in
          
                self.detailSegment.hidden = false
                self.tableView.hidden = false
                self.instructionsLabel.hidden = false
                self.story.hidden = true
                //self.story.setNeedsUpdateConstraints()
               
               self.story.layoutIfNeeded()
                
        }
        
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as? CustomCell {
            
            cell.label.text = ingredientsArray[indexPath.row]
            
            let backgroundView = UIView()
            backgroundView.backgroundColor = UIColor.clearColor()
            cell.selectedBackgroundView = backgroundView
            
            return cell
        }
        
        return CustomCell()

    }
    
    @IBAction func detailSegAction(sender: AnyObject) {
        if detailSegment.selectedSegmentIndex == 1 {
           
            let player = AVPlayer(URL: NSURL(string: videoURL)!)
            let playerViewController = AVPlayerViewController()
            playerViewController.player = player
            self.presentViewController(playerViewController, animated: true) {
                playerViewController.player!.play()
            } } else {
                
        }
        
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredientsArray.count
    }
    
    
    override func didUpdateFocusInContext(context: UIFocusUpdateContext, withAnimationCoordinator coordinator: UIFocusAnimationCoordinator) {
        
        // segueToggle = false
        //collectionView.reloadData()
        
        if let prev = context.previouslyFocusedView as? UIButton {
            
            prev.setImage(UIImage(named: "EmptyB.png"), forState: UIControlState.Normal)
            
           /* UIView.animateWithDuration(0.5, animations: { () -> Void in
            
                prev.movieLbl.frame.size = self.titleDefaultSize
            })*/
            
            
        }
        
        if let next = context.nextFocusedView as? UIButton {
            
             next.setImage(UIImage(named: "FullB.png"), forState: UIControlState.Normal)
            
           /* UIView.animateWithDuration(0.5, animations: { () -> Void in
                next.movieLbl.frame.size = self.titleFocusSize
               
                
            })*/
            
        }
    }

}

