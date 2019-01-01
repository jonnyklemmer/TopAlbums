//
//  MasterViewController.swift
//  TopAlbums
//
//  Created by Jonny Klemmer on 12/31/18.
//  Copyright © 2018 Jonny Klemmer. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var viewModel: AlbumsViewModel? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        AlbumService().fetchAlbums { [weak self] (albums) in
            let albumVMs = albums.map { AlbumViewModel(withAlbum: $0) }
            self?.viewModel = AlbumsViewModel(albumViewModels: albumVMs)
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfAlbums ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let albumVM = viewModel?.viewModel(atIndex: indexPath.row) else {
            return UITableViewCell()
        }
        
        let cell = UITableViewCell()
        cell.textLabel?.text = albumVM.name
        return cell
    }
}
