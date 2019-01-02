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
        
        addCustomViews()
    }
    
    private func addCustomViews() {
        let albumImageView = UIImageView(image: image)
        albumImageView.heightAnchor.constraint(equalToConstant: 200.0).isActive = true

        let albumNameLabel = createLabel(text: viewModel.name,
                                         textStyle: .title1)

        let artistNameLabel = createLabel(text: viewModel.artistName,
                                          textStyle: .title2)

        let releaseDateLabel = createLabel(text: viewModel.releaseDate,
                                           color: .lightGray)
        
        let genreLabel = createLabel(text: viewModel.genres.joined(separator: ", "),
                                         color: .lightGray)

        let copyrightLabel = createLabel(text: viewModel.copyright,
                                         color: .lightGray,
                                         textStyle: .caption1)

        let switcherButton = UIButton(type: .system)
        switcherButton.setTitle("View on iTunes Store", for: .normal)
        switcherButton.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
        
        
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

        stackView.safeAreaLayoutGuide.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        stackView.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                                                              constant: -20.0).isActive = true
        
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20.0).isActive = true
    }
    
    /// Helper function for creating labels for UI.
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

