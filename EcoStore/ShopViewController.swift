//
//  ShopViewController.swift
//  EcoStore
//
//  Created by Pragnath Chintalapati on 1/16/21.
//

import UIKit

class ShopViewController: UIViewController {
    
    @IBOutlet var shopCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        shopCollectionView.delegate = self
        shopCollectionView.dataSource = self
    }

}
extension ShopViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        collectionView.deselectItem(at: indexPath, animated: true)
    
    }

}

extension ShopViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShopCollectionViewCell", for: indexPath) as! ShopCollectionViewCell
        
        
        return cell
    }
    
}
// Lets you specify margin and padding between each cell (WILL WORK ON THIS SOON)
// extension ViewController: UICollectionViewDelegateFlowLayout{}
