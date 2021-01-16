//
//  ProductUIViewController.swift
//  EcoStore
//
//  Created by Pragnath Chintalapati on 1/15/21.
//

import UIKit

class ProductDetailsViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionView: UITextView!
    @IBOutlet weak var storeLabel: UIButton!
    @IBOutlet weak var charityLabel: UILabel!
    
    var product: Product!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = product.title
        priceLabel.text = String(format: "$%.2f", product.price)
        storeLabel.setTitle("By " + product.storeTitle, for: .normal)
        descriptionView.text = product.description
        charityLabel.text = "Supporting " + product.charity + "\n with \(  product.percentDonated) % of price"
    }

    @IBAction func storeLabelClicked(_ sender: Any) {
        let shopVc = storyboard?.instantiateViewController(identifier: "ShopViewController") as! ShopViewController
        shopVc.id = product!.storeId
        self.modalPresentationStyle = .overFullScreen
        self.present(shopVc, animated: true, completion: nil)
    }
}
