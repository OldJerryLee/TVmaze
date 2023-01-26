//
//  UITableView+Ext.swift
//  TVmaze
//
//  Created by Fabricio Pujol on 25/01/23.
//

import UIKit

extension UITableView {
    func reloadDataOnMainThread() {
        DispatchQueue.main.async {
            self.reloadData()
        }
    }

    func removeExcessCells () {
        tableFooterView = UIView(frame: .zero)
    }
}
