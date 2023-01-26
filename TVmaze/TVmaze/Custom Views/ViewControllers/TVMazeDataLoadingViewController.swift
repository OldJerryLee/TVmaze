//
//  TVMazeDataLoadingVewController.swift
//  TVmaze
//
//  Created by Fabricio Pujol on 20/01/23.
//

import UIKit

class TVMazeDataLoadingViewController: UIViewController {
    var containerView: UIView!
    var emptyStateView: TVMazeEmptyStateView!

    func showLoadingView() {
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)

        containerView.backgroundColor = .systemBackground
        containerView.alpha = 0

        UIView.animate(withDuration: 0.25) {
            self.containerView.alpha = 0.8
        }

        let activityIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicator)

        activityIndicator.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])

        activityIndicator.startAnimating()
    }

    func dismissLoadingView() {
        DispatchQueue.main.async {
            self.containerView.removeFromSuperview()
            self.containerView = nil
        }
    }

    func showEmptyStateView(with message: String, in view: UIView) {
        emptyStateView = TVMazeEmptyStateView(message: message)
        emptyStateView.frame = view.bounds
        view.addSubview(emptyStateView)
    }

    func dismissEmptyStateView() {
        if !(emptyStateView == nil) {
            DispatchQueue.main.async {
                self.emptyStateView.removeFromSuperview()
                self.emptyStateView = nil
            }
        }
    }
}
