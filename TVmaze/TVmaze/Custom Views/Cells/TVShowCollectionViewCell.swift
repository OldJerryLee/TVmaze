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
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(tvShow: TVShowElement) {
        if let image = tvShow.show.image, let original = image.original {
            tvShowImageView.downloadImage(fromUrl: original)
        }
        tvShowImageView.image = UIImage(named: "film-poster-placeholder")
        titleLabel.text = tvShow.show.name
        statusLabel.text = tvShow.show.status.rawValue

        if tvShow.show.status.rawValue == "Ended" {
            statusLabel.backgroundColor = .systemRed
        } else {
            statusLabel.backgroundColor = .systemGreen
        }
    }

    private func configure() {

        titleLabel.textColor = .white
        titleLabel.backgroundColor = .systemGray4
        titleLabel.layer.cornerRadius = 5
        titleLabel.layer.borderWidth = 1
        titleLabel.layer.borderColor = UIColor.white.cgColor
        titleLabel.layer.masksToBounds = true

        statusLabel.textColor = .white
        statusLabel.layer.cornerRadius = 5
        statusLabel.layer.borderWidth = 1
        statusLabel.layer.borderColor = UIColor.white.cgColor
        statusLabel.layer.masksToBounds = true

        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = 10

        addSubview(tvShowImageView)
        addSubview(titleLabel)
        addSubview(statusLabel)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tvShowImageView.topAnchor.constraint(equalTo: topAnchor),
            tvShowImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tvShowImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tvShowImageView.bottomAnchor.constraint(equalTo: bottomAnchor),

            titleLabel.bottomAnchor.constraint(equalTo: statusLabel.topAnchor, constant: -4),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            titleLabel.heightAnchor.constraint(equalToConstant: 22),

            statusLabel.bottomAnchor.constraint(equalTo: tvShowImageView.bottomAnchor, constant: -4),
            statusLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            statusLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            statusLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}
