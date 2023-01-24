//
//  TVShowDetailsViewController.swift
//  TVmaze
//
//  Created by Fabricio Pujol on 22/01/23.
//

import UIKit

class TVShowDetailsViewController: TVMazeDataLoadingVewController {

    private var viewModel: TVShowDetailsViewModelProtocol

    init(viewModel: TVShowDetailsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        viewModel = TVShowDetailsViewModel()
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        print(viewModel.tvShow?.show.name)
        setupBind()
        viewModel.fetchTVShowsAkas(id: (viewModel.tvShow?.show.id)!)
        // Do any additional setup after loading the view.
    }

    private func setupBind() {
        viewModel.showLoading = { [weak self] in
            self?.showLoadingView()
        }

        viewModel.hideLoading = { [weak self] in
            self?.dismissLoadingView()
        }

        viewModel.updateUI = { [weak self] in
            //self?.updateUI(with: (self?.viewModel.tvShows)!)
            print(self?.viewModel.akas)
        }

        viewModel.presentAlert = { [weak self] error in
            self?.presentTVMazeAlertOnMainThread(title: "Bad stuff happend", message: error, buttonTitle: "Ok")
        }
    }
}
