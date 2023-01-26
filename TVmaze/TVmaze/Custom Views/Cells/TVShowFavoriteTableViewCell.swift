//
//  TVShowFavoriteTableViewCell.swift
//  TVmaze
//
//  Created by Fabricio Pujol on 25/01/23.
//

import UIKit

class FavoriteCell: UITableViewCell {
    static let reuseID = "FavoriteCell"
    let tvShowImageView = TVMazeImageView(frame: .zero)
    let titleLabel = TVMazeTitleLabel(textAlignment: .left, fontSize: 26)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(favorite: TVShowElement) {
        if let image = favorite.show.image, let original = image.medium {
            tvShowImageView.downloadImage(fromUrl: original)
        }
        tvShowImageView.image = UIImage(named: "film-poster-placeholder")
        titleLabel.text = favorite.show.name
    }

    private func configure() {
        self.addSubview(tvShowImageView)
        self.addSubview(titleLabel)

        accessoryType = .disclosureIndicator
        let padding: CGFloat = 12

        NSLayoutConstraint.activate([
            tvShowImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            tvShowImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            tvShowImageView.heightAnchor.constraint(equalToConstant: 60),
            tvShowImageView.widthAnchor.constraint(equalToConstant: 60),

            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: tvShowImageView.trailingAnchor, constant: 24),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
