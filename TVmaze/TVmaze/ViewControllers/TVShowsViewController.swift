//
//  TVShowsViewController.swift
//  TVmaze
//
//  Created by Fabricio Pujol on 19/01/23.
//

import UIKit

class TVShowsViewController: TVMazeDataLoadingVewController {
    //TODO: Put the marks
    //TODO: Fix Layout of cells
    //TODO: Make Logic of Status

    enum Section {
        case main
    }

    private var viewModel: TVShowsViewModelProtocol

    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, TVShowElement>!

    init(viewModel: TVShowsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        viewModel = TVShowsViewModel()
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureCollectionView()
        updateUI(with: viewModel.tvShows)
        configureDataSource()
        configureSearchController()
        setupBind()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createTwoColumnFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(TVShowCollectionViewCell.self, forCellWithReuseIdentifier: TVShowCollectionViewCell.reuseID)
    }

    func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search for a TV Show..."
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }

    func updateUI(with tvShows: TVShows) {

        if viewModel.tvShows.isEmpty {
            let message = "There is no TV Show searched yet. Go search some!! :)"
            DispatchQueue.main.async {
                self.showEmptyStateView(with: message, in: self.view)
            }
            return
        }

        self.dismissEmptyStateView()
        
        self.updateData(on: viewModel.tvShows)
    }

    func configureDataSource(){
        dataSource = UICollectionViewDiffableDataSource<Section, TVShowElement>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell?  in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TVShowCollectionViewCell.reuseID, for: indexPath) as! TVShowCollectionViewCell
            let show = self.viewModel.tvShows[indexPath.row]
            cell.set(tvShow: show)
            return cell
        })
    }

    func updateData(on tvShows: TVShows) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, TVShowElement>()
        snapshot.appendSections([.main])
        snapshot.appendItems(tvShows)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }

    private func setupBind() {
        viewModel.showLoading = { [weak self] in
            self?.showLoadingView()
        }

        viewModel.hideLoading = { [weak self] in
            self?.dismissLoadingView()
        }

        viewModel.updateUI = { [weak self] in
            self?.updateUI(with: (self?.viewModel.tvShows)!)
        }

        viewModel.presentAlert = { [weak self] error in
            self?.presentTVMazeAlertOnMainThread(title: "Bad stuff happend", message: error, buttonTitle: "Ok")
        }
    }
}

extension TVShowsViewController: UICollectionViewDelegate {
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let detailsViewModel = TVShowDetailsViewModel()
            detailsViewModel.tvShow = viewModel.tvShows[indexPath.row]
            let destinationViewController = TVShowDetailsViewController(viewModel: detailsViewModel)
            let navController = UINavigationController(rootViewController: destinationViewController)
            present(navController, animated: true)
        }
}

extension TVShowsViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let filter = searchBar.text, !filter.isEmpty else { return }
        viewModel.tvShows.removeAll()
        viewModel.fetchTVShows(title: filter)
    }
}
