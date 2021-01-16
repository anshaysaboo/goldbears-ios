//
//  ShopViewController.swift
//  EcoStore
//
//  Created by Pragnath Chintalapati on 1/16/21.
//

import UIKit

class ShopViewController: UIViewController {
    
    @IBOutlet var shopCollectionView: UICollectionView!

    var store: Store?
    var products: [Product] = []

    override func viewDidLoad() {
        shopCollectionView.delegate = self
        shopCollectionView.dataSource = self
        loadStore()
    }
    
    func loadStore() {
        APIManager.getStoreDetails(id: "60027c63b10b44a8553080cf") { (store, success) in
            if !success || store == nil {
                // TODO: HANDLE ERROR
                return
            }
            
            self.store = store!
            self.products = store!.products
            self.shopCollectionView.reloadData()
        }
    }

}

extension ShopViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if store == nil {
            return collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ShopHeader", for: indexPath) as! ShopHeaderCollectionReusableView
        }
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ShopHeader", for: indexPath) as! ShopHeaderCollectionReusableView
            headerView.titleLabel.text = store!.title
            headerView.ownerLabel.text = "By @" + store!.owner
            headerView.descriptionLabel.text = store!.description
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
