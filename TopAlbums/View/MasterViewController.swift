//
//  MasterViewController.swift
//  TopAlbums
//
//  Created by Jonny Klemmer on 12/31/18.
//  Copyright © 2018 Jonny Klemmer. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {
    var viewModel: AlbumListViewModel? {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    private let cellReuseIdentifier = "AlbumTableViewCellReuseID"
    
    private var imageCache: [String: UIImage] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        fetchAlbums()
    }
    
    @objc private func handleRefresh() {
        fetchAlbums()
    }
    
    private func setupView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        tableView.estimatedRowHeight = 100.0
        tableView.rowHeight = 100.0
        
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        refreshControl?.beginRefreshing()
        
        title = "iTunes Top 100"
    }
    
    
    private func fetchAlbums() {
        AlbumService().fetchAlbums { [weak self] (albums) in
            DispatchQueue.main.async {
                let albumVMs = albums.map { AlbumViewModel(withAlbum: $0) }
                self?.viewModel = AlbumListViewModel(albumViewModels: albumVMs)
                self?.refreshControl?.endRefreshing()
            }
        }
    }

    // MARK:- UITableViewDataSource functions
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfAlbums ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
        
        guard let albumVM = viewModel?.viewModel(atIndex: indexPath.row) else {
            return UITableViewCell()
        }
        
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = "\(albumVM.albumName)\n\(albumVM.artistName)"
        
        if let image = imageCache[albumVM.thumbnailUrl] {
            cell.imageView?.image = image
            cell.setNeedsLayout()
        } else {
            AlbumService().fetchAlbumImage(url: albumVM.thumbnailUrl) { [weak self, weak cell] (data) in
                if let image = UIImage(data: data) {
                    self?.imageCache[albumVM.thumbnailUrl] = image
                    DispatchQueue.main.async {
                        cell?.imageView?.image = image
                        cell?.setNeedsLayout()
                    }
                }
            }
        }
        
        return cell
    }
    
    // MARK:- UITableViewDelegate functions
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let albumVM = viewModel?.viewModel(atIndex: indexPath.row) else {
            return
        }
        
        let detailViewController = DetailViewController()
        detailViewController.viewModel = albumVM
        detailViewController.image = imageCache[albumVM.thumbnailUrl]
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}
