//
//  ProductUIViewController.swift
//  EcoStore
//
//  Created by Pragnath Chintalapati on 1/15/21.
//

import UIKit
import TagListView

class ProductDetailsViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionView: UITextView!
    @IBOutlet weak var storeLabel: UIButton!
    @IBOutlet weak var charityLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var goalLabel: UILabel!
    @IBOutlet weak var tagsView: TagListView!
    
    var product: Product!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = product.title
        priceLabel.text = String(format: "$%.2f", product.price)
        storeLabel.setTitle("By " + product.storeTitle, for: .normal)
        descriptionView.text = product.description
        charityLabel.text = "\(Int(product.percentDonated))% goes to \(product.charity)"
        
        if product.hasImage() {
            imageView.loadImage(withURL: URL(string: product.imageUrl)!)
        }
        
        charityLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openCharityLink)))
        charityLabel.isUserInteractionEnabled = true
        
        let goal = Int.random(in: 2...10) * 1000
        let moneyRaised = Int.random(in: 0...999) + (goal - Int.random(in: 0...(goal / 2) - 1000))
        goalLabel.text = "$\(moneyRaised) out of $\(goal) raised!"
        progressBar.progress = Float(moneyRaised) / Float(goal)
        tagsView.addTags(product!.tags)
    }
    
    @objc func openCharityLink() {
        if let url = URL(string: product!.charityLink) {
            UIApplication.shared.open(url)
        }
    }

    @IBAction func storeLabelClicked(_ sender: Any) {
        let shopVc = storyboard?.instantiateViewController(identifier: "ShopViewController") as! ShopViewController
        shopVc.id = product!.storeId
        self.modalPresentationStyle = .overFullScreen
        self.present(shopVc, animated: true, completion: nil)
    }
    
    @IBAction func closeClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
