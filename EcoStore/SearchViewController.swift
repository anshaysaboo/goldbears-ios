//
//  ViewController.swift
//  EcoStore
//
//  Created by Anshay Saboo on 1/15/21.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet var productCollectionView: UICollectionView!
    
    var products: [Product] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        productCollectionView.delegate = self
        productCollectionView.dataSource = self
        let flowLayout = UICollectionViewFlowLayout()
        productCollectionView.collectionViewLayout = flowLayout
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadResults()
    }
    
    func loadResults() {
        let query = searchField.text!
        // if query.isEmpty { return }
        
        APIManager.searchForProducts(query: "candle") { (products, success) in
            if !success {
                // TODO: Display error box
                return
            }
            self.products = products
            print(products)
            self.productCollectionView.reloadData()
        }
    }
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCollectionViewCell
        let product = products[indexPath.row]
        
        cell.nameLabel.text = product.title
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let optimalSideSpacing = (self.view.frame.size.width - 340.0) / 3.0
        print(optimalSideSpacing)
        return UIEdgeInsets(top: optimalSideSpacing, left: optimalSideSpacing, bottom: 0, right: optimalSideSpacing)
    }
       
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return (self.view.frame.size.width - 340.0) / 3.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 170.0, height: 250.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.transform = CGAffineTransform(translationX: 0, y: cell.frame.height / 2)
        cell.alpha = 0
        UIView.animate(
            withDuration: 0.35,
            delay: indexPath.row < 8 ? 0.1*Double(indexPath.row) : 0.05,
            options: [.curveEaseInOut],
            animations: {
                cell.transform = CGAffineTransform(translationX: 0, y: 0)
                cell.alpha = 1
        })
    }

}
