//
//  TVShowDetailsViewController.swift
//  TVmaze
//
//  Created by Fabricio Pujol on 22/01/23.
//

import UIKit

class TVShowDetailsViewController: TVMazeDataLoadingVewController {
    //TODO: Put the marks 

    private var viewModel: TVShowDetailsViewModelProtocol

    let scrollView = UIScrollView()
    let stackView = UIStackView()
    let containerStackView = UIStackView()

    let avatarImageView = TVMazeImageView(frame: .zero)
    let ratingLabel = TVMazeTitleLabel(textAlignment: .left, fontSize: 24)
    let akasLabel = TVMazeSecondaryTitleLabel(fontSize: 18)
    let sumaryLabel = TVMazeBodyLabel(textAlignment: .justified)

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
        setupBind()
        //TODO: Remove Force
        viewModel.fetchTVShowsAkas(id: (viewModel.tvShow?.show.id)!)
        configureViewController()
        configureUIElements()
        setupConstraints()
    }

    func configureUIElements() {
        settingUIElements()

        stackView.spacing = 8
        stackView.axis = .vertical

        containerStackView.spacing = 16
        containerStackView.axis = .vertical
        containerStackView.backgroundColor = .lightGray
        containerStackView.layer.borderColor = UIColor.darkGray.cgColor
        containerStackView.layer.borderWidth = 1
        containerStackView.layer.cornerRadius = 5
        containerStackView.layer.masksToBounds = true
        containerStackView.layoutMargins = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        containerStackView.isLayoutMarginsRelativeArrangement = true

        avatarImageView.layer.borderColor = UIColor.darkGray.cgColor
        avatarImageView.layer.borderWidth = 1
        avatarImageView.layer.masksToBounds = true

        ratingLabel.backgroundColor = viewModel.getRatingColor()
        ratingLabel.textColor = .white
        ratingLabel.textAlignment = .center
        ratingLabel.layer.borderWidth = 2
        ratingLabel.layer.borderColor = UIColor.white.cgColor
        ratingLabel.layer.cornerRadius = 25
        ratingLabel.layer.masksToBounds = true

        sumaryLabel.numberOfLines = 0

        akasLabel.numberOfLines = 0
        akasLabel.textAlignment = .center
    }

    func settingUIElements() {
        //TODO: Remove Force
        avatarImageView.downloadImage(fromUrl: (viewModel.tvShow?.show.image.original)!)

        //TODO: Put this logic on VM
        if let average = viewModel.tvShow?.show.rating?.average {
            ratingLabel.text = average.description
        } else {
            ratingLabel.text = "N/R"
        }

        //TODO: Put this logic on VM
        if let summary = viewModel.tvShow?.show.summary {
            sumaryLabel.text = summary.stripOutHtml()
        } else {
            sumaryLabel.text = "No summary was provided =/"
        }
    }

    func setupConstraints() {
        view.addSubview(scrollView)
        view.addSubview(ratingLabel)

        scrollView.addSubview(stackView)

        stackView.addArrangedSubview(avatarImageView)
        stackView.addArrangedSubview(containerStackView)
        containerStackView.addArrangedSubview(sumaryLabel)
        containerStackView.addArrangedSubview(akasLabel)

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),

            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),

            avatarImageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            avatarImageView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.9),
            avatarImageView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 1.20),

            ratingLabel.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: -8),
            ratingLabel.trailingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: -8),
            ratingLabel.widthAnchor.constraint(equalToConstant: 50),
            ratingLabel.heightAnchor.constraint(equalToConstant: 50),
        ])
    }

    private func setupBind() {
        viewModel.updateUI = { [weak self] in
            DispatchQueue.main.async {
                self?.akasLabel.text = self?.viewModel.getAkasText()
            }
        }

        viewModel.presentAlert = { [weak self] error in
            self?.presentTVMazeAlertOnMainThread(title: "Bad stuff happend", message: error, buttonTitle: "Ok")
        }
    }

    func configureViewController() {
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
        self.title = viewModel.tvShow?.show.name
    }

    @objc func dismissVC() {
        dismiss(animated: true)
    }
}
