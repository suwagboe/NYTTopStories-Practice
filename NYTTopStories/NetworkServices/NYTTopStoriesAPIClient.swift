//
//  NYTTopStoriesAPIClient.swift
//  NYTTopStories
//
//  Created by Pursuit on 2/6/20.
//  Copyright © 2020 Pursuit. All rights reserved.
//

import Foundation
import NetworkHelper

struct NYTTopStoriesAPIClient {
    static func fetchTopStorties(for section: String, completion: @escaping (Result<[Article], AppError>)-> ()) {
        let endpointURL = "https://api.nytimes.com/svc/topstories/v2/nyregion.json?api-key=..."
        
        guard let url = URL(string: endpointURL) else {
            completion(.failure(.badURL(endpointURL)))
            return
        }
        
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result{
            case .failure(let appError):
                // this is where the decoding of the data should happen and return the data
                completion(.failure(.decodingError(appError)))
            case .success(let data):
                do{
                    // remember to ALWAYS go from the top level and then go deeper inside of the model
                    let stories = try JSONDecoder().decode(TopStories.self, from: data)
                    completion(.success(stories.results))
                }catch{
                    completion(.failure(.decodingError(error)))
                }
                
            }
        }
        
    }
}
