//
//  FeedViewController.swift
//  EcoStore
//
//  Created by Anshay Saboo on 1/16/21.
//

import UIKit

import UIKit

class FeedViewController: UIViewController {
    
    @IBOutlet var feedCollectionView: UICollectionView!

    var products: [Product] = []
    
    var id = ""

    override func viewDidLoad() {
        feedCollectionView.delegate = self
        feedCollectionView.dataSource = self
        loadResults()
    }
    
    func loadResults() {
        APIManager.getProductFeed { (products, success) in
            if !success {
                // TODO: Display error box
                return
            }
            self.products = products
            self.feedCollectionView.reloadData()
        }
    }

    @IBAction func closeClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension FeedViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "FeedHeader", for: indexPath)
            return headerView
        case UICollectionView.elementKindSectionFooter:
            return UICollectionReusableView()
        default:
            fatalError()
        }
    }
    
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
        let optimalSideSpacing = ((self.view.frame.size.width - 340.0) / 3.0)
        print(optimalSideSpacing)
        return UIEdgeInsets(top: optimalSideSpacing, left: optimalSideSpacing, bottom: 0, right: optimalSideSpacing)
    }
       
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return ((self.view.frame.size.width - 340.0) / 3.0)
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
