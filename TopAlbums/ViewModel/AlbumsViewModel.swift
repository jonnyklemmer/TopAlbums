//
//  AlbumsViewModel.swift
//  TopAlbums
//
//  Created by Jonny Klemmer on 12/31/18.
//  Copyright © 2018 Jonny Klemmer. All rights reserved.
//

import Foundation

struct AlbumViewModel {
    let artistName: String
    let releaseDate: String
    let name: String
    let copyright: String
    
    let genres: [String]
    let imageUrl: String
    
    init(withAlbum album: Album) {
        self.artistName = album.artistName
        self.releaseDate = album.releaseDate
        self.name = album.name
        self.copyright = album.copyright
        
        self.genres = album.genres.map { $0.name }
        self.imageUrl = album.artworkUrl100
    }
}

class AlbumsViewModel {
    private var albumViewModels: [AlbumViewModel]
    
    init(albumViewModels: [AlbumViewModel]) {
        self.albumViewModels = albumViewModels
    }
    
    // MARK:- Public variables & functions
    
    public var numberOfAlbums: Int {
        return albumViewModels.count
    }
    
    public func viewModel(atIndex index: Int) -> AlbumViewModel? {
        guard albumViewModels.indices.contains(index) else {
            print("Invalid index given for album view model.")
            return nil
        }
        
        return albumViewModels[index]
    }
}
