//
//  BannerTableViewCell.swift
//  PizzaApp
//
//  Created by Leysan Latypova on 19.10.2022.
//

import UIKit

class BannerTableViewCell: UITableViewCell {
    
    static let identifier = "BannerTableViewCell"
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var banners: [Banner] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
//MARK: - UICollectionViewDataSource, UICollectionViewDelegate
extension BannerTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return banners.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let banner = banners[indexPath.row]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCollectionViewCell.identifier, for: indexPath) as? BannerCollectionViewCell else { fatalError() }
        
        cell.configure(with: banner)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 300, height: 130)
    }
}

