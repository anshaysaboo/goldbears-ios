//
//  Cells.swift
//  EcoStore
//
//  Created by Pragnath Chintalapati on 1/15/21.
//

import Foundation
import UIKit
import TagListView

// Each ProductCell displays a single product.

class ProductCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var tagView: TagListView!
    
    func setup(_ product: Product) {
        self.nameLabel.text = product.title
        self.tagView.removeAllTags()
        self.tagView.addTags(product.tags)
    }
}

class ShopHeaderCollectionReusableView: UICollectionReusableView {
    @IBOutlet weak var headerImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ownerLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
}
