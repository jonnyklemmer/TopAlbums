//
//  AlbumListViewModel.swift
//  TopAlbums
//
//  Created by Jonny Klemmer on 12/31/18.
//  Copyright © 2018 Jonny Klemmer. All rights reserved.
//

import Foundation

class AlbumListViewModel {
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
