//
//  Models.swift
//  Cocktails
//
//  Created by Stephen Casella on 11/21/15.
//  Copyright © 2015 Stephen Casella. All rights reserved.
//

import UIKit
import AVFoundation

func downloadData(id: String, title: UILabel, image: UIImageView, story: UILabel, instructions: UILabel, table: UITableView!, placeholder: UIImageView) {

dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
    
let mappedURLString = "http://addb.absolutdrinks.com/drinks/" + id + "/?apiKey=c2c7c5a8a6ef4985a3e35301cde21554"
    
let mappedURL = NSURL(string: mappedURLString)

let data = NSData(contentsOfURL: mappedURL!)

if data != nil {
    
    do { let jsonData = try NSJSONSerialization.JSONObjectWithData(data!, options:NSJSONReadingOptions.MutableContainers) as! NSDictionary
        
        if let ingFormat = jsonData["result"]![0]["ingredients"] as? NSArray {
               
            for ingredient in ingFormat {
                let ingFormat = ingredient as! [String:String]
                    ingredientsArray.append(ingFormat["textPlain"]!)
                
            }
            
        } else {
            print("false")
        }
        
            if let items = jsonData["result"] as? NSArray {
            
            for item in items {
                
                let titleI = item["name"]! as! String
            
                 let storyI = item["story"]! as! String
                
                 let instructionsI = item["descriptionPlain"]! as! String
                
                 let videoI = item["videos"]!![1]["video"] as! String
            
                
                dispatch_sync(dispatch_get_main_queue()){
                  
                    title.text = titleI
                    story.text = storyI
                   
                        
                        instructions.text = instructionsI
                        videoURL = "http://assets.absolutdrinks.com/videos/" + videoI
                        
                        table.reloadData()
                       
                    }
                    
                 let downloadImg = UIImage(data: NSData(contentsOfURL: NSURL(string: "http://assets.absolutdrinks.com/drinks/transparent-background-white/soft-shadow/floor-reflection/\(id).png")!)!)
               
                dispatch_sync(dispatch_get_main_queue()){
                    placeholder.hidden = true 
                    image.image = downloadImg
                }

                }}
        
    } catch {
        
        print("not a dictionary")
        
    } }

    })
}




