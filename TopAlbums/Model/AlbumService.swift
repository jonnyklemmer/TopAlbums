//
//  AlbumService.swift
//  TopAlbums
//
//  Created by Jonny Klemmer on 1/1/19.
//  Copyright © 2019 Jonny Klemmer. All rights reserved.
//

import Foundation

typealias AlbumsCompletionHandler = ([Album]) -> Void
typealias AlbumImageDataCompletionHandler = (Data) -> Void

struct AlbumService {
    func fetchAlbums(completionHandler: @escaping AlbumsCompletionHandler) {
        guard let url = URL(string: "https://rss.applemarketingtools.com/api/v2/us/music/most-played/100/albums.json") else {
            print("Failed fetch albums when parsing string into URL.")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                do {
                    // Convert the data to JSON
                    let jsonSerialized = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]

                    if let json = jsonSerialized,
                        let feed = json["feed"] as? [String : Any],
                        let results = feed["results"]
                    {
                        print(feed)
                        let resultsData = try JSONSerialization.data(withJSONObject: results, options: [])
                        let albums = try JSONDecoder().decode([Album].self, from: resultsData)
                        completionHandler(albums)
                    }
                }  catch let error as NSError {
                    print(error.localizedDescription)
                }
            } else if let error = error {
                print(error.localizedDescription)
            }
        }

        task.resume()
    }
    
    func fetchAlbumImage(url: String, completionHandler: @escaping AlbumImageDataCompletionHandler) {
        guard let url = URL(string: url) else {
            print("Failed fetch albums when parsing string into URL.")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                completionHandler(data)
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
        
        task.resume()
    }
}
