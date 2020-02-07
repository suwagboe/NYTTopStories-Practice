//
//  TopStoryModel.swift
//  NYTTopStories
//
//  Created by Pursuit on 2/6/20.
//  Copyright © 2020 Pursuit. All rights reserved.
//

import Foundation

enum ImageFormat: String{
    // these are the ONLY types that they can have
    // this makes the code type safe..
    // use raw values to get the
    // whenever we want the image you would just call it
    case supeJumbo = "supeJumbo" // want this
    case thumbLarge = "thumbLarge" // want this
    case standardThumbnail = "Standard Thumbnail"
    case normal = "Normal" // need to write it as it is inside of the json file
}

/*  enum is based on the info inside of
 "url": "https://static01.nyt.com/images/2020/02/07/nyregion/07BABY/07BABY-superJumbo.jpg",
                  "format": "superJumbo"
              },
              {
                  "url": "https://static01.nyt.com/images/2020/02/07/nyregion/07BABY/07BABY-thumbStandard.jpg",
                  "format": "Standard Thumbnail"
              },
              {
                  "url": "https://static01.nyt.com/images/2020/02/07/nyregion/07BABY/07BABY-thumbLarge.jpg",
                  "format": "thumbLarge"
 */

struct TopStories: Codable {
       let section: String
       let lastUpdated: String
       let results: [Article]
       
       // doing a coding key
       private enum CodingKeys: String, CodingKey{
           case section
           case lastUpdated = "last_updated"
           case results
       }
   }
   
   struct Article: Codable {
       let section: String
       let title: String
       let abstract: String
       let publishedDate: String
       let multimedia: [Multimedia]
       
       private enum CodingKeys: String, CodingKey{
           // the codingKey String is for the coding keys themselves.. not for the type it is taking in..
           case section,title,abstract,multimedia
           case publishedDate = "published_date"
       }
   }
// want to write code in model to easily access the info
   
   struct Multimedia: Codable {
       let url: String
       let format: String // superJumbo, thumbLarge
       let height: Double
       let width: Double
       let caption: String
   }


extension Article { // article.getArticleImageURL(.superJumbo)
    // we are extending the model
    // including a function
    // not a static because we would use it on the article ITSELF
    
    func getArticleImageURl(for imageFormat: ImageFormat) -> String {
        // we are in a article and have access to multimedia which is the array of images
        // now we are saying filer based on what is being looked for
        let results = multimedia.filter {$0.format == imageFormat.rawValue}
        // so it says is the fomart we are looking at the one we are asking for.
        
        
        // where ever the first instance of the type that is being looked for.
        guard let seletedMultimediaImage = results.first else {
        
            // if we dont get a result like if results is 0 then return a type of empty image.
            // and then we would put in what we want.
            return ""
        }
        
        // return the ACTUAL image
        return seletedMultimediaImage.url
    }
    
}
