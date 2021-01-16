//
//  ViewController.swift
//  EcoStore
//
//  Created by Anshay Saboo on 1/15/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var productCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        productCollectionView.delegate = self
        productCollectionView.dataSource = self
        
    }
}

extension ViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        collectionView.deselectItem(at: indexPath, animated: true)
    
    }

}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCollectionViewCell", for: indexPath) as! ProductCollectionViewCell
        
        
        return cell
    }
    
}
// Lets you specify margin and padding between each cell (WILL WORK ON THIS SOON)
// extension ViewController: UICollectionViewDelegateFlowLayout{}
