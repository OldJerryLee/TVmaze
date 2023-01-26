//
//  UIHelper.swift
//  TVmaze
//
//  Created by Fabricio Pujol on 20/01/23.
//

import UIKit

enum UIHelper {
    static func createTwoColumnFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
        let width = view.bounds.width
        let padding: CGFloat = 12
        let minimumItemSpacing: CGFloat = 10
        let avaiableWidth = width - (padding * 2) - minimumItemSpacing
        let itemWidth = avaiableWidth/2

        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth * 1.26)

        return flowLayout
    }
}
