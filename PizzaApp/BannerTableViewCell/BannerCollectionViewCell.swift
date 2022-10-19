//
//  BannerCollectionViewCell.swift
//  PizzaApp
//
//  Created by Leysan Latypova on 19.10.2022.
//

import UIKit

class BannerCollectionViewCell: UICollectionViewCell {
    static let identifier = "BannerCollectionViewCell"
    
    @IBOutlet var bannerImageView: UIImageView!
    
    public func configure(with banner: Banner) {
        guard let imageUrl = URL(string: banner.imageUrl) else { fatalError() }
        bannerImageView.image = nil
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: imageUrl) {
                DispatchQueue.main.async {
                    self.bannerImageView.image = UIImage(data: data)
                }
            }
        }
    }
}
