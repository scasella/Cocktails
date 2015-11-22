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
var setSeg = 0

class NavController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var segmentController: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var ingredientsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        segmentController.layer.borderColor = UIColor.whiteColor().CGColor
        segmentController.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.whiteColor()], forState: UIControlState.Normal)
        segmentController.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.whiteColor()], forState: UIControlState.Selected)
        
        setupSegment(setSeg)
        
        
        
    }
    
    
    
    override func didUpdateFocusInContext(context: UIFocusUpdateContext, withAnimationCoordinator coordinator: UIFocusAnimationCoordinator) {
        
        if let next = context.nextFocusedView as? CustomCell {
            
            let index = nameArray.indexOf(next.label.text!)
           
            ingredientsLabel.text = ingredientsArray[index!]
            
        }
    }
    
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        id = idArray[indexPath.row]
        print(id)
        performSegueWithIdentifier("toMain", sender: self)
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as? CustomCell {
            
            
            cell.label.text = nameArray[indexPath.row]
            cell.drinkImg.image = UIImage(data: imageArray[indexPath.row])
            
            let backgroundView = UIView()
            backgroundView.backgroundColor = UIColor.clearColor()
            cell.selectedBackgroundView = backgroundView
            
            return cell
            
        }
        
        return CustomCell()

    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
    
    
    
    func setupSegment(set: Int) {
        
        if set == 0 {
            
            segmentController.setTitle("Bourbon", forSegmentAtIndex: 0)
            segmentController.setTitle("Gin", forSegmentAtIndex: 1)
            segmentController.setTitle("Light Rum", forSegmentAtIndex: 2)
            segmentController.setTitle("Dark Rum", forSegmentAtIndex: 3)
            segmentController.setTitle("Tequila", forSegmentAtIndex: 4)
            segmentController.setTitle("Vodka", forSegmentAtIndex: 5) //
            
            
        downloadData("", title: UILabel(), image: UIImageView(), story: UILabel(), instructions: UILabel(), table: tableView, placeholder: UIImageView(), taste: "", occasion: "", spirit: "bouron")
            
        } else if set == 1 {
        
            segmentController.setTitle("Berry", forSegmentAtIndex: 0)
            segmentController.setTitle("Bitter", forSegmentAtIndex: 1)
            segmentController.setTitle("Fresh", forSegmentAtIndex: 2)
            segmentController.setTitle("Fruity", forSegmentAtIndex: 3)
            segmentController.setTitle("Herb", forSegmentAtIndex: 4)
            segmentController.setTitle("Palpable", forSegmentAtIndex: 5)
            segmentController.setTitle("Sour", forSegmentAtIndex: 6)
            segmentController.setTitle("Spicy", forSegmentAtIndex: 7)
            segmentController.setTitle("Sweet", forSegmentAtIndex: 8)
            
            downloadData("", title: UILabel(), image: UIImageView(), story: UILabel(), instructions: UILabel(), table: tableView, placeholder: UIImageView(), taste: "sweet", occasion: "", spirit: "")
            
        } else if set == 2 {
            segmentController.setTitle("Afternoon", forSegmentAtIndex: 0)
            segmentController.setTitle("Evening", forSegmentAtIndex: 1)
            segmentController.setTitle("Pre-Dinner", forSegmentAtIndex: 2)
            segmentController.setTitle("After Dinner", forSegmentAtIndex: 3)
            
            downloadData("", title: UILabel(), image: UIImageView(), story: UILabel(), instructions: UILabel(), table: tableView, placeholder: UIImageView(), taste: "", occasion: "afternoon", spirit: "")


        }

            //http://addb.absolutdrinks.com/occasions/?apiKey=c2c7c5a8a6ef4985a3e35301cde21554

    }
    
   }
