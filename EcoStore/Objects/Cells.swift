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
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var tagView: TagListView!
    
    func setup(_ product: Product) {
        self.nameLabel.text = product.title
        self.tagView.removeAllTags()
        self.tagView.addTags(product.tags)
        self.priceLabel.text = String(format: "$%.2f", product.price)
        self.iconView.layer.cornerRadius = 5.0
        self.iconView.clipsToBounds = true
        self.iconView.contentMode = .scaleAspectFill
        if product.hasImage() {
            iconView.loadImage(withURL: URL(string: product.imageUrl)!)
        }
    }
}

class ShopHeaderCollectionReusableView: UICollectionReusableView {
    @IBOutlet weak var headerImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ownerLabel: UILabel!
    @IBOutlet weak var totalRaisedLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
}

class CardView: UIView {
    override func layoutSubviews() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.1
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowRadius = 5
        self.layer.cornerRadius = 10.0
    }
}
