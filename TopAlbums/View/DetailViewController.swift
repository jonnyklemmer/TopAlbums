//
//  DetailViewController.swift
//  TopAlbums
//
//  Created by Jonny Klemmer on 12/31/18.
//  Copyright © 2018 Jonny Klemmer. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var viewModel: AlbumViewModel!
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "Details"
        
        addCustomViews()
    }
    
    private func addCustomViews() {
        
        let albumImageView = createAlbumImageView()

        let albumNameLabel = createLabel(text: viewModel.albumName,
                                         textStyle: .title1)

        let artistNameLabel = createLabel(text: viewModel.artistName,
                                          textStyle: .title2)

        let releaseDateLabel = createLabel(text: viewModel.releaseDate,
                                           color: .lightGray)
        
        let genreLabel = createLabel(text: viewModel.genres,
                                         color: .lightGray)

        let copyrightLabel = createLabel(text: viewModel.copyright,
                                         color: .lightGray,
                                         textStyle: .caption1)

        let switcherButton = UIButton(type: .system)
        switcherButton.setTitle("View on iTunes Store", for: .normal)
        switcherButton.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
        switcherButton.addTarget(self, action: #selector(openMusicApp), for: .touchUpInside)
        
        
        let spacerView = UIView()

        let stackView = UIStackView(arrangedSubviews: [albumImageView,
                                                       albumNameLabel,
                                                       artistNameLabel,
                                                       releaseDateLabel,
                                                       genreLabel,
                                                       copyrightLabel,
                                                       spacerView,
                                                       switcherButton])
        stackView.spacing = 8.0
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)

        setupStackViewConstraints(stackView)
    }
    
    @objc private func openMusicApp() {
        if let url = URL(string: viewModel.albumUrl), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    private func setupStackViewConstraints(_ stackView: UIStackView) {
        stackView.safeAreaLayoutGuide.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                                           constant: 20.0).isActive = true
        stackView.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                                                              constant: -20.0).isActive = true
        
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20.0).isActive = true
    }
    
    private func createAlbumImageView() -> UIImageView {
        let albumImageView = UIImageView(image: image)
        albumImageView.contentMode = .scaleAspectFit
        albumImageView.heightAnchor.constraint(equalToConstant: 200.0).isActive = true

        // Async load the higher quality image
        AlbumService().fetchAlbumImage(url: viewModel.imageUrl) { [weak albumImageView] (data) in
            if let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    albumImageView?.image = image
                    albumImageView?.setNeedsLayout()
                }
            }
        }
        
        return albumImageView
    }
    
    /// Helper function for creating labels. Text is required.
    /// All other parameters will default to values listed below.
    ///
    /// - Parameters:
    ///   - text: Required.
    ///   - color: UIColor.black
    ///   - textStyle: UIFont.TextStyle.body
    ///   - numberOfLines: 0
    /// - Returns: UILabel object with the given properties pre-configured.
    private func createLabel(text: String,
                             color: UIColor = .black,
                             textStyle: UIFont.TextStyle = .body,
                             numberOfLines: Int = 0) -> UILabel
    {
        let label = UILabel()
        label.text = text
        label.textColor = color
        label.font = UIFont.preferredFont(forTextStyle: textStyle)
        label.numberOfLines = numberOfLines
        return label
    }
}

