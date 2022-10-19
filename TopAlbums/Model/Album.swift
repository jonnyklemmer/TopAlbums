//
//  Album.swift
//  TopAlbums
//
//  Created by Jonny Klemmer on 12/31/18.
//  Copyright © 2018 Jonny Klemmer. All rights reserved.
//

import Foundation

struct Album: Codable {
    let artistName: String
    let id: String
    let releaseDate: String
    let name: String
    let copyright: String?
    
    let genres: [Genre]
    
    let artworkUrl100: String
    let url: String
}

struct Genre: Codable {
    let genreId: String
    let name: String
}
