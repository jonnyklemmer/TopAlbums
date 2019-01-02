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
    let imageUrl: String
    let albumUrl: String
    
    init(withAlbum album: Album) {
        self.artistName = album.artistName
        self.releaseDate = album.releaseDate
        self.albumName = album.name
        self.copyright = album.copyright
        
        self.genres = album.genres.map { $0.name }.joined(separator: ", ")
        self.imageUrl = album.artworkUrl100
        self.albumUrl = album.url
    }
}
