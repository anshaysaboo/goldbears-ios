//
//  Extensions.swift
//  EcoStore
//
//  Created by Anshay Saboo on 1/16/21.
//

import Foundation
import UIKit
import Kingfisher

extension UIImageView {
    func loadImage(withURL url: URL) {
        let processor = DownsamplingImageProcessor(size: self.frame.size)
        self.kf.indicatorType = .activity
        self.kf.setImage(
            with: url,
            placeholder: UIImage(named: "EmptyImage"),
            options: [
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(0.5)),
                .cacheOriginalImage
            ])
        {
            result in
            switch result {
            case .success(let value):
                print("Task done for: \(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
    }
}

extension UIViewController {
    func displayErrorMessage() {
        let alert = UIAlertController(title: "Oops!", message: "Please use a stable connection and try again later.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
