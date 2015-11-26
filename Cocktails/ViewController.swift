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
var defaultID = ""
var startUp = true
var nameSearch = ""

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
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var defaultButton: UIButton!
    @IBOutlet weak var onboardView: UIView!
    
    
    
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
        
        
        if favIDArray.indexOf(id) != nil {
            favButton.setTitle("Unfavorite", forState: UIControlState.Normal)
            //favButton.userInteractionEnabled = false
        }
        
        if startUp == true {
        if defaultID != "" {
        downloadData(defaultID, title: label, image: image, story: story, instructions: instructionsLabel, table: tableView, placeholder: drinkImg, taste: "", occasion: "", spirit: "", fromNav: false)
            
        } else {
            onboardView.hidden = false
        }
         
       startUp = false
        } else {
            downloadData(id, title: label, image: image, story: story, instructions: instructionsLabel, table: tableView, placeholder: drinkImg, taste: "", occasion: "", spirit: "", fromNav: false)

        }
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func navBarPressed(sender: UITapGestureRecognizer) {
        if segmentControl.selectedSegmentIndex == 0 || segmentControl.selectedSegmentIndex == 1 || segmentControl.selectedSegmentIndex == 2 || segmentControl.selectedSegmentIndex == 3 {
            
            setSeg = segmentControl.selectedSegmentIndex
            performSegueWithIdentifier("toNav", sender: self)
            
        } else {
            //Search name alert view
            var tField: UITextField!
            
            func configurationTextField(textField: UITextField!)
            {
                textField.placeholder = "Enter an item"
                tField = textField
            }
            
            
            func handleCancel(alertView: UIAlertAction!)
            {
            }
            
            let alert = UIAlertController(title: "Search by Drink Name", message: "", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler:handleCancel))
            alert.addTextFieldWithConfigurationHandler(configurationTextField)
                        alert.addAction(UIAlertAction(title: "Search", style: UIAlertActionStyle.Default, handler:{ (UIAlertAction)in
                nameSearch = (tField.text as String!).lowercaseStringWithLocale(NSLocale(localeIdentifier: "en_US"))
                self.performSegueWithIdentifier("toNav", sender: self)
            }))
            
            self.presentViewController(alert, animated: true, completion: {
                
            })
        }
        
        //
    }
    
    
    
    @IBAction func favPressed() {
        
         if favIDArray.indexOf(id) == nil {
        favButton.setTitle("Unfavorite", forState: UIControlState.Normal)
        favIDArray.append(id)
        NSUserDefaults.standardUserDefaults().setObject(favIDArray, forKey: "favIDArray")
        defaultButton.hidden = false
            
            if favIDArray.count == 1 {
               defaultID = id
               NSUserDefaults.standardUserDefaults().setObject(defaultID, forKey: "defaultID")
               defaultButton.enabled = false
            }
            
         } else {
            favButton.setTitle("Favorite", forState: UIControlState.Normal)
            favIDArray.removeAtIndex(favIDArray.indexOf(id)!)
            defaultButton.hidden = true
            if defaultID == id {
                defaultID = ""
                NSUserDefaults.standardUserDefaults().setObject(defaultID, forKey: "defaultID")
            }
            NSUserDefaults.standardUserDefaults().setObject(favIDArray, forKey: "favIDArray")
        }
    }
    
    
    
     @IBAction func defaultPressed() {
        defaultID = id
        NSUserDefaults.standardUserDefaults().setObject(defaultID, forKey: defaultID)
        defaultButton.enabled = false
    }
    
    
    
    var overFocus = false
    
    @IBAction func showButtonPressed() {
        overFocus = true
        showButton.userInteractionEnabled = false 
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
                self.favButton.hidden = false
                self.tableView.hidden = false
                self.instructionsLabel.hidden = false
                self.story.hidden = true
                
                if favIDArray.indexOf(id) != nil {
                self.defaultButton.hidden = false
                if id == defaultID {
                    self.defaultButton.enabled = false
                    }
                }
        }
        self.setNeedsFocusUpdate()
        self.updateFocusIfNeeded()
        
        }
    
    
    
    override weak var preferredFocusedView: UIView? {
        if overFocus == true {
            detailSegment.selectedSegmentIndex = 1
            return detailSegment
        }
        return showButton
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
            
            if videoURL != "" {
           
            let player = AVPlayer(URL: NSURL(string: videoURL)!)
            let playerViewController = AVPlayerViewController()
            playerViewController.player = player
            self.presentViewController(playerViewController, animated: true) {
                playerViewController.player!.play()
                } } else {
                
                let alert = UIAlertController(title: "Video unavailable.", message: "", preferredStyle: UIAlertControllerStyle.Alert)
                presentViewController(alert, animated: true, completion: nil)
            }
            
            } else {
                
        }
        
    }
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if ingredientsArray.count < 6 {
            tableView.userInteractionEnabled = false 
        }
        return ingredientsArray.count
    }
    
    
    
    override func didUpdateFocusInContext(context: UIFocusUpdateContext, withAnimationCoordinator coordinator: UIFocusAnimationCoordinator) {
        
        // segueToggle = false
        //collectionView.reloadData()
        
        if let prev = context.previouslyFocusedView as? UIButton {
            
            if prev.restorationIdentifier == "Show" {
            prev.setImage(UIImage(named: "EmptyB.png"), forState: UIControlState.Normal)
            } else if prev.restorationIdentifier == "Fav"{
            //  prev.layer.frame.size.width = 150
              //prev.layer.frame.size.height = 102
            }
            
           /* UIView.animateWithDuration(0.5, animations: { () -> Void in
            
                prev.movieLbl.frame.size = self.titleDefaultSize
            })*/
            
            
        }
        
        if let next = context.nextFocusedView as? UIButton {
            
            
            if next.restorationIdentifier == "Show" {
                next.setImage(UIImage(named: "FullB.png"), forState: UIControlState.Normal)
            } else if next.restorationIdentifier == "Fav"{
            //    next.layer.frame.size.width = 200
              //  next.layer.frame.size.height = 152
            }
            
            
           /* UIView.animateWithDuration(0.5, animations: { () -> Void in
                next.movieLbl.frame.size = self.titleFocusSize
               
                
            })*/
            
        }
    }

}

