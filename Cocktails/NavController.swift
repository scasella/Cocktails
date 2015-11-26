//
//  NavController.swift
//  Cocktails
//
//  Created by Stephen Casella on 11/21/15.
//  Copyright © 2015 Stephen Casella. All rights reserved.
//

import UIKit

var nameArray = [String]()
var imageArray = [NSData]()
var idArray = [String]()
var setSeg = 3
var favIDArray = [String]()

class NavController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var segmentController: UISegmentedControl!
    @IBOutlet weak var spiritSegment: UISegmentedControl!
    @IBOutlet weak var occaSegment: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var ingredientsLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        segmentController.hidden = true
        spiritSegment.hidden = true
        occaSegment.hidden = true
    }
    
    
    override func viewWillAppear(animated: Bool) {
        
        ingredientsArray.removeAll()
        nameArray.removeAll()
        idArray.removeAll()
        imageArray.removeAll()
    
        tableView.reloadData()
        
        tableView.userInteractionEnabled = false
        
        if nameSearch != "" {
            downloadData("", title: UILabel(), image: UIImageView(), story: UILabel(), instructions: UILabel(), table: tableView, placeholder: UIImageView(), taste: "", occasion: "afternoon", spirit: "", fromNav: false)
            titleLabel.text = "Search Results"
        } else {
        setupSegment(setSeg)
        }
    }
    
    
    
    override func didUpdateFocusInContext(context: UIFocusUpdateContext, withAnimationCoordinator coordinator: UIFocusAnimationCoordinator) {
        
        
        if let next = context.nextFocusedView as? CustomCell {
            
            let index = nameArray.indexOf(next.label.text!)
            
             ingredientsLabel.text = ingredientsArray[index!]
            
        }
    }
    
    
    
    @IBAction func segPressed(sender: UITapGestureRecognizer) {
        
        ingredientsLabel.text = ""
        
        if setSeg == 0 {
            
            if spiritSegment.selectedSegmentIndex == 2 {
                
                downloadData("", title: UILabel(), image: UIImageView(), story: UILabel(), instructions: UILabel(), table: tableView, placeholder: UIImageView(), taste: "", occasion: "", spirit: "light-rum", fromNav: false)
                
            } else if spiritSegment.selectedSegmentIndex == 3 {
                
                downloadData("", title: UILabel(), image: UIImageView(), story: UILabel(), instructions: UILabel(), table: tableView, placeholder: UIImageView(), taste: "", occasion: "", spirit: "dark-rum-aged", fromNav: false)
                
                
            } else if spiritSegment.selectedSegmentIndex == 5 {
                downloadData("", title: UILabel(), image: UIImageView(), story: UILabel(), instructions: UILabel(), table: tableView, placeholder: UIImageView(), taste: "", occasion: "", spirit: "absolut-vodka", fromNav: false)
            
                
            } else {
            
                downloadData("", title: UILabel(), image: UIImageView(), story: UILabel(), instructions: UILabel(), table: tableView, placeholder: UIImageView(), taste: "", occasion: "", spirit: (spiritSegment.titleForSegmentAtIndex(spiritSegment.selectedSegmentIndex)?.lowercaseStringWithLocale(NSLocale(localeIdentifier: "en_US")))!, fromNav: false)
            
        }
        
        } else if setSeg == 1 {
           
             downloadData("", title: UILabel(), image: UIImageView(), story: UILabel(), instructions: UILabel(), table: tableView, placeholder: UIImageView(), taste: (segmentController.titleForSegmentAtIndex(segmentController.selectedSegmentIndex)?.lowercaseStringWithLocale(NSLocale(localeIdentifier: "en_US")))!, occasion: "", spirit: "", fromNav: false)
            
        } else if setSeg == 2 {
            //NEED TO SET UP OCCASIONS
            
        }
        
        
        
    }
    
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        id = idArray[indexPath.row]
      
        tableView.userInteractionEnabled = false
        performSegueWithIdentifier("toMain", sender: self)
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as? CustomCell {
            
            
            cell.label.text = nameArray[indexPath.row]
        
                cell.drinkImg.image = UIImage(data: imageArray[indexPath.row]) 
            
            let backgroundView = UIView()
            backgroundView.backgroundColor = UIColor.blackColor()
            cell.selectedBackgroundView = backgroundView
            
            cell.drinkImg.layer.cornerRadius = 15.0
            
            return cell
            
        }
        
        return CustomCell()

    }
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
    
    
    
    func setupSegment(set: Int) {
        
        if set == 0 {
            
            spiritSegment.hidden = false
            segmentController.hidden = true
            occaSegment.hidden = true
            
            titleLabel.text = "Spirits"
            
            spiritSegment.layer.borderColor = UIColor.whiteColor().CGColor
            spiritSegment.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.whiteColor()], forState: UIControlState.Normal)
            spiritSegment.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.whiteColor()], forState: UIControlState.Selected)
            
            
        downloadData("", title: UILabel(), image: UIImageView(), story: UILabel(), instructions: UILabel(), table: tableView, placeholder: UIImageView(), taste: "", occasion: "", spirit: "bourbon", fromNav: false)
            
        } else if set == 1 {
            
            spiritSegment.hidden = true
            segmentController.hidden = false
            occaSegment.hidden = true

            titleLabel.text = "Tastes"
            
           segmentController.layer.borderColor = UIColor.whiteColor().CGColor
            segmentController.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.whiteColor()], forState: UIControlState.Normal)
            segmentController.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.whiteColor()], forState: UIControlState.Selected)
            
            
            downloadData("", title: UILabel(), image: UIImageView(), story: UILabel(), instructions: UILabel(), table: tableView, placeholder: UIImageView(), taste: "sweet", occasion: "", spirit: "", fromNav: false)
            
        } else if set == 2 {
            
            spiritSegment.hidden = true
            segmentController.hidden = true
            occaSegment.hidden = false
            
            titleLabel.text = "Occasions"
            
            occaSegment.layer.borderColor = UIColor.whiteColor().CGColor
            occaSegment.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.whiteColor()], forState: UIControlState.Normal)
            occaSegment.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.whiteColor()], forState: UIControlState.Selected)
            
            downloadData("", title: UILabel(), image: UIImageView(), story: UILabel(), instructions: UILabel(), table: tableView, placeholder: UIImageView(), taste: "", occasion: "afternoon", spirit: "", fromNav: false)


        } else if set == 3 {
            
            titleLabel.text = "Favorites"
            
            var favsIDs = ""
            var counter = 0
            for i in favIDArray {
                if counter >= 1 {
                favsIDs = favsIDs + ",\(i)"
                } else {
                    favsIDs = favsIDs + "\(i)"
                }
                counter++
            }
          print(favsIDs)
            downloadData(favsIDs, title: UILabel(), image: UIImageView(), story: UILabel(), instructions: UILabel(), table: tableView, placeholder: UIImageView(), taste: "", occasion: "", spirit: "", fromNav: true)
        } 
    }
    
   }
