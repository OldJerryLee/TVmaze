//
//  UIViewController+Extension.swift
//  TVmaze
//
//  Created by Fabricio Pujol on 20/01/23.
//

import UIKit
import SafariServices

extension UIViewController {
    func presentTVMazeAlertOnMainThread(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertVC = TVMazeAlertViewController(title: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
}
