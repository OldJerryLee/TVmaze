//
//  FavoritesTvShowsController.swift
//  TVmaze
//
//  Created by Fabricio Pujol on 19/01/23.
//

import UIKit

class FavoritesTvShowsViewController: TVMazeDataLoadingViewController {
    //MARK: UI
    let tableView = UITableView()

    //MARK: View Model
    private var viewModel: FavoritesTVShowsViewModelProtocol

    init(viewModel: FavoritesTVShowsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        viewModel = FavoritesTVShowsViewModel()
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
        setupBind()
    }

    override func viewWillAppear(_ animated: Bool) {
        viewModel.getFavorites()
    }

    func configureViewController() {
        view.backgroundColor = .systemBackground
        title = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    func configureTableView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.rowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self
        tableView.removeExcessCells()

        tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.reuseID)
    }

    func updateUI(with favorites: [TVShowElement]) {
        if viewModel.favorites.isEmpty {
            self.showEmptyStateView(with: "No favorites?\nAdd one on the TV Shows screen.", in: self.view)
        } else {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.view.bringSubviewToFront(self.tableView)
            }
        }
    }

    private func setupBind() {
        viewModel.updateUI = { [weak self] in
            self?.updateUI(with: (self?.viewModel.favorites)!)
        }

        viewModel.presentAlert = { [weak self] error in
            self?.presentTVMazeAlertOnMainThread(title: "Bad stuff happend", message: error, buttonTitle: "Ok")
        }
    }
}

    //MARK: UITableViewDelegate
extension FavoritesTvShowsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.favorites.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.reuseID) as! FavoriteCell
        let favorite = viewModel.favorites[indexPath.row]
        cell.set(favorite: favorite)

        return cell
    }
}

    //MARK: UITableViewDataSource
extension FavoritesTvShowsViewController: UITableViewDataSource {
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let detailsViewModel = TVShowDetailsViewModel()
            detailsViewModel.tvShow = viewModel.favorites[indexPath.row]
            let destinationViewController = TVShowDetailsViewController(viewModel: detailsViewModel)
            let navController = UINavigationController(rootViewController: destinationViewController)
            present(navController, animated: true)
        }

        func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            guard editingStyle == .delete else { return }

            PersistenceManager.updatewith(favorite: viewModel.favorites[indexPath.row], actionType: .remove) { [weak self] error in
                guard let self = self else { return }
                guard let error = error else {
                    self.viewModel.favorites.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .left)
                    return
                }
                self.presentTVMazeAlertOnMainThread(title: "Unable to remove", message: error.rawValue, buttonTitle: "Ok")
            }
        }
}
