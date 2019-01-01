//
//  AlbumsViewModel.swift
//  TopAlbums
//
//  Created by Jonny Klemmer on 12/31/18.
//  Copyright © 2018 Jonny Klemmer. All rights reserved.
//

import Foundation

class AlbumsViewModel {
    var albums: [Album] = []
    
    func fetchAlbums() {
        AlbumService().fetchAlbums { [weak self] (albums) in
            self?.albums = albums
        }
    }
}
