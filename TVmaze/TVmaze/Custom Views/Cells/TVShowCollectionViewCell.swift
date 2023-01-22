//
//  TVShowTableViewCell.swift
//  TVmaze
//
//  Created by Fabricio Pujol on 19/01/23.
//

import UIKit

class TVShowCollectionViewCell: UICollectionViewCell {
    static let reuseID = "TVShowCollectionViewCell"

    let tvShowImageView = TVMazeImageView(frame: .zero)
    let titleLabel = TVMazeTitleLabel(textAlignment: .center, fontSize: 24)
    let statusLabel = TVMazeTitleLabel(textAlignment: .center, fontSize: 16)

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(tvShow: TVShowElement) {
        tvShowImageView.downloadImage(fromUrl: tvShow.show.image.original)
        titleLabel.text = tvShow.show.name
        statusLabel.text = tvShow.show.status.rawValue
    }

    private func configure() {
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = 10
        addSubview(tvShowImageView)
        addSubview(titleLabel)
        addSubview(statusLabel)

        let padding: CGFloat = 8

        NSLayoutConstraint.activate([
            tvShowImageView.topAnchor.constraint(equalTo: topAnchor),
            tvShowImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tvShowImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tvShowImageView.bottomAnchor.constraint(equalTo: bottomAnchor),

            titleLabel.topAnchor.constraint(equalTo: tvShowImageView.bottomAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 20),

            statusLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: padding),
            statusLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            statusLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}
