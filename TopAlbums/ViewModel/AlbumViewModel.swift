//
//  AlbumViewModel.swift
//  TopAlbums
//
//  Created by Jonny Klemmer on 1/1/19.
//  Copyright © 2019 Jonny Klemmer. All rights reserved.
//

import Foundation

struct AlbumViewModel {
    let artistName: String
    let releaseDate: String
    let albumName: String
    let copyright: String
    
    let genres: String
    let thumbnailUrl: String
    let albumUrl: String

    /// HACK: Leverage Apple image URL APIs to fetch a higher resolution
    /// album artwork image URL. Likely to break in the future 🔥
    var imageUrl: String {
        guard thumbnailUrl.contains("100x100") else {
            // Fallback to thumbnail URL
            return thumbnailUrl
        }

        return thumbnailUrl.replacingOccurrences(of: "100x100", with: "400x400")
    }
    
    init(withAlbum album: Album) {
        self.artistName = album.artistName
        self.releaseDate = album.releaseDate
        self.albumName = album.name
        self.copyright = album.copyright ?? ""
        
        self.genres = album.genres.map { $0.name }.joined(separator: ", ")
        self.thumbnailUrl = album.artworkUrl100
        self.albumUrl = album.url
    }
}
