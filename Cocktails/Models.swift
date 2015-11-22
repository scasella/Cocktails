//
//  Models.swift
//  Cocktails
//
//  Created by Stephen Casella on 11/21/15.
//  Copyright © 2015 Stephen Casella. All rights reserved.
//

import UIKit
import AVFoundation

func downloadData(id: String, title: UILabel, image: UIImageView, story: UILabel, instructions: UILabel, table: UITableView!, placeholder: UIImageView, taste: String, occasion: String, spirit: String) {

    ingredientsArray.removeAll()
    nameArray.removeAll()
    idArray.removeAll()
    imageArray.removeAll()
    
dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
    
var mappedURLString = ""

if id != "" {
    
 mappedURLString = "http://addb.absolutdrinks.com/drinks/" + id + "/?apiKey=c2c7c5a8a6ef4985a3e35301cde21554"
    
} else if taste != "" {
    mappedURLString = "http://addb.absolutdrinks.com/drinks/tasting/\(taste)/?apiKey=c2c7c5a8a6ef4985a3e35301cde21554"
} else if occasion != "" {
    mappedURLString = "http://addb.absolutdrinks.com/drinks/for/\(occasion)/?apiKey=c2c7c5a8a6ef4985a3e35301cde21554"
} else if spirit != "" {
    mappedURLString = "http://addb.absolutdrinks.com/drinks/with/\(spirit)/?apiKey=c2c7c5a8a6ef4985a3e35301cde21554"
}
    
let mappedURL = NSURL(string: mappedURLString)

let data = NSData(contentsOfURL: mappedURL!)

if data != nil {
    
    do { let jsonData = try NSJSONSerialization.JSONObjectWithData(data!, options:NSJSONReadingOptions.MutableContainers) as! NSDictionary
        
        for ingFormat in (jsonData["result"]! as? NSArray)! {
            
            var tempText = ""
            
            if id == "" {
            for ingredient in (ingFormat["ingredients"] as? NSArray)! {
                let ingFormat = ingredient as! [String:String]
                    tempText = tempText + "\(ingFormat["textPlain"]!), "
              
            }
                
                ingredientsArray.append(tempText)
  
                
            } else {
                
                for ingredient in (ingFormat["ingredients"] as? NSArray)! {
                    let ingFormat = ingredient as! [String:String]
                    ingredientsArray.append(ingFormat["textPlain"]!)

                }
            }
            
            
        }
        
    
    
            if let items = jsonData["result"] as? NSArray {
                
            if items.count == 1  {
            
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
                
                 let downloadImg = UIImage(data: NSData(contentsOfURL: NSURL(string: "http://assets.absolutdrinks.com/drinks/transparent-background-white/floor-reflection/\(id).png")!)!)
               
                dispatch_sync(dispatch_get_main_queue()){
                    placeholder.hidden = true 
                    image.image = downloadImg
                }

                }
                
            } else if items.count > 1 {
                
                for item in items {
                    
                    let idPull = item["id"]! as! String
                    
                    idArray.append(idPull)
                    nameArray.append(item["name"]! as! String)
                    ingredientsArray.append(item["descriptionPlain"]! as! String)
                    
                    if let _ = NSData(contentsOfURL: NSURL(string: "http://assets.absolutdrinks.com/drinks/transparent-background-black/172x167/\(idPull)(40).jpg")!) {
                    
                    imageArray.append(NSData(contentsOfURL: NSURL(string: "http://assets.absolutdrinks.com/drinks/transparent-background-black/172x167/\(idPull)(40).jpg")!)!)
                    
                    } else {
                        imageArray.append(NSData())
                    }
                    
                    dispatch_sync(dispatch_get_main_queue()){
                        table.reloadData()
                    }
                    
                }
                
            }

        }
    } catch {
        
        print("not a dictionary")
        
    } }

    })
    
        
}




