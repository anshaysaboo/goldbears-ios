//
//  ViewController.swift
//  EcoStore
//
//  Created by Anshay Saboo on 1/15/21.
//

import UIKit
import TagListView

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet var productCollectionView: UICollectionView!
    
    var products: [Product] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        searchField.delegate = self
        productCollectionView.delegate = self
        productCollectionView.dataSource = self
    }

    
    func loadResults() {
        let query = searchField.text!
        if query.isEmpty { return }
        
        APIManager.searchForProducts(query: query) { (products, success) in
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
        let details = storyboard?.instantiateViewController(identifier: "ProductDetailsViewController") as! ProductDetailsViewController
        details.product = products[indexPath.row]
        self.present(details, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCollectionViewCell
        let product = products[indexPath.row]
        
        cell.setup(product)
        
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
        cell.transform = CGAffineTransform(translationX: 0, y: cell.frame.height / 4)
        cell.alpha = 0
        UIView.animate(
            withDuration: 0.15,
            delay: indexPath.row < 8 ? 0.1*Double(indexPath.row) : 0.05,
            options: [.curveEaseInOut],
            animations: {
                cell.transform = CGAffineTransform(translationX: 0, y: 0)
                cell.alpha = 1
        })
    }

}

extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.loadResults()
        return true
    }
}
