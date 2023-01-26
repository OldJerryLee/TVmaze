//
//  FavoritesTvShowsViewModel.swift
//  TVmaze
//
//  Created by Fabricio Pujol on 26/01/23.
//

import Foundation

protocol FavoritesTVShowsViewModelProtocol {
    var updateUI: (() -> Void)? { get set }
    var presentAlert: ((String)-> Void)? { get set }
    var favorites: [TVShowElement] { get set }

    func getFavorites()
}

class FavoritesTVShowsViewModel: FavoritesTVShowsViewModelProtocol {
    var updateUI: (() -> Void)?
    var presentAlert: ((String) -> Void)?

    var favorites:[TVShowElement] = []

    func getFavorites() {
        PersistenceManager.retrieveFavorites { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let favorites):
                self.favorites = favorites
                self.updateUI?()
            case .failure(let error):
                self.presentAlert?(error.localizedDescription)
            }
        }
    }
}
