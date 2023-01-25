//
//  TVShowDetailsViewModel.swift
//  TVmaze
//
//  Created by Fabricio Pujol on 23/01/23.
//

import Foundation
import UIKit

protocol TVShowDetailsViewModelProtocol {
    var updateUI: (() -> Void)? { get set }
    var presentAlert: ((String)-> Void)? { get set }
    var tvShow: TVShowElement? { get set }
    var akas: Akas { get set }

    func fetchTVShowsAkas(id: Int)
    func getRatingColor() -> UIColor
    func getAkasText() -> String
}

class TVShowDetailsViewModel: TVShowDetailsViewModelProtocol {
    var updateUI: (() -> Void)?
    var presentAlert: ((String) -> Void)?

    var tvShow: TVShowElement? = nil
    var akas: Akas = []

    private let service = NetworkManager.shared

    func fetchTVShowsAkas(id: Int) {
        service.getAkas(for: id) { [weak self] result in
            guard let self = self else { return }
                switch result {
                    case .success(let akas):
                        self.akas = akas
                        self.updateUI?()
                    case .failure(let error):
                        self.presentAlert?(error.rawValue)
            }
        }
    }

    func getRatingColor() -> UIColor {
        guard let tvShow = tvShow, let rating = tvShow.show.rating, let average = rating.average else {
            return .darkGray
        }

        if average < 5.0 {
            return .systemRed
        } else if average < 7.0 {
            return .systemYellow
        } else {
            return .systemGreen
        }
    }

    func getAkasText() -> String {
        if akas.isEmpty { return "No akas were provided =/" }

        var akaTexts: [String] = []

        for aka in akas {
            akaTexts.append(aka.name)
        }

        let akaText = "Akas: \(akaTexts.joined(separator: ", "))"

        return akaText
    }
}
