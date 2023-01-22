//
//  TVShowsViewModel.swift
//  TVmaze
//
//  Created by Fabricio Pujol on 22/01/23.
//

import Foundation

protocol TVShowsViewModelProtocol {
    var showLoading: (() -> Void)? { get set }
    var hideLoading: (() -> Void)? { get set }
    var updateUI: (() -> Void)? { get set }
    var presentAlert: ((String)-> Void)? { get set }
    var tvShows: [TVShowElement] { get set }

    func fetchTVShows(title: String)
}

class TVShowsViewModel: TVShowsViewModelProtocol {
    var updateUI: (() -> Void)?
    var showLoading: (() -> Void)?
    var hideLoading: (() -> Void)?
    var presentAlert: ((String) -> Void)?

    var tvShows: [TVShowElement] = []

    private let service = NetworkManager.shared

    func fetchTVShows(title: String) {
        showLoading?()
        service.getTVShows(for: title) { [weak self] result in
            guard let self = self else { return }
            self.hideLoading?()

            switch result {
                case .success(let tvShows):
                    self.tvShows = tvShows
                    self.updateUI?()
                case .failure(let error):
                    self.presentAlert?(error.rawValue)
            }
        }
    }
}
