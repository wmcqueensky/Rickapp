//
//  HeightCollectionView.swift
//  Rickapp
//
//  Created by Wojciech Mokwiński on 27/09/2023.
//

import UIKit

class HeightCollectionView: UICollectionView {
    override var contentSize:CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }

    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: collectionViewLayout.collectionViewContentSize.height)
    }
}
