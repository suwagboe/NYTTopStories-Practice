//
//  TopStoryModel.swift
//  NYTTopStories
//
//  Created by Pursuit on 2/6/20.
//  Copyright © 2020 Pursuit. All rights reserved.
//

import Foundation

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
   
   struct Multimedia: Codable {
       let url: String
       let format: String
       let height: Double
       let width: Double
       let caption: String
   }
