//
//  TopAlbumsTests.swift
//  TopAlbumsTests
//
//  Created by Jonny Klemmer on 12/31/18.
//  Copyright © 2018 Jonny Klemmer. All rights reserved.
//

import XCTest
@testable import TopAlbums

class TopAlbumsTests: XCTestCase {
    
    var viewModel: AlbumListViewModel!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let albumVM = AlbumViewModel(withAlbum: Album(artistName: "artistName",
                                                      id: "id",
                                                      releaseDate: "releaseDate",
                                                      name: "name",
                                                      copyright: "copyright",
                                                      genres: [Genre(genreId: "genreId", name: "genre-name"),
                                                               Genre(genreId: "genreId2", name: "genre-name2")],
                                                      artworkUrl100: "artworkUrl100",
                                                      url: "url"))
        viewModel = AlbumListViewModel(albumViewModels: [albumVM])
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAlbumInitializedSuccessfully() {
        XCTAssertTrue(viewModel.numberOfAlbums > 0)
    }

    func testAlbumDataParsedSuccessfully() {
        guard let albumVM = viewModel.viewModel(atIndex: 0) else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(albumVM.artistName, "artistName")
        XCTAssertEqual(albumVM.releaseDate, "releaseDate")
        XCTAssertEqual(albumVM.albumName, "name")
        XCTAssertEqual(albumVM.copyright, "copyright")
        
        XCTAssertEqual(albumVM.genres, "genre-name, genre-name2")
        XCTAssertEqual(albumVM.imageUrl, "artworkUrl100")
    }

}
