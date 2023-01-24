//
//  TVShowDetailsViewModel.swift
//  TVmaze
//
//  Created by Fabricio Pujol on 23/01/23.
//

import Foundation

protocol TVShowDetailsViewModelProtocol {
    var showLoading: (() -> Void)? { get set }
    var hideLoading: (() -> Void)? { get set }
    var updateUI: (() -> Void)? { get set }
    var presentAlert: ((String)-> Void)? { get set }
    var tvShow: TVShowElement? { get set }
    var akas: Akas { get set }

    func fetchTVShowsAkas(id: Int)
}

class TVShowDetailsViewModel: TVShowDetailsViewModelProtocol {
    var showLoading: (() -> Void)?
    var hideLoading: (() -> Void)?
    var updateUI: (() -> Void)?
    var presentAlert: ((String) -> Void)?

    var tvShow: TVShowElement? = nil
    var akas: Akas = []

    private let service = NetworkManager.shared

    func fetchTVShowsAkas(id: Int) {
        showLoading?()
        service.getAkas(for: id) { [weak self] result in
            guard let self = self else { return }
            self.hideLoading?()
                switch result {
                    case .success(let akas):
                        self.akas = akas
                        self.updateUI?()
                    case .failure(let error):
                        self.presentAlert?(error.rawValue)
            }
        }
    }
}
