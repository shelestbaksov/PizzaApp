//
//  TableCollectionViewCell.swift
//  PizzaApp
//
//  Created by Leysan Latypova on 18.10.2022.
//

import UIKit

class TableCollectionViewCell: UICollectionViewCell {
    static let identifier = "TableCollectionViewCell"
    
    private let myImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private let myLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(myLabel)
        contentView.addSubview(myImageView)
        contentView.addSubview(priceLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        myImageView.frame = CGRect(x: 5,
                                   y: 5,
                                   width: contentView.frame.size.width-10,
                                   height: contentView.frame.size.height-5)
    }
    public func configure(with model: Banner) {
        let url = URL(string: model.imageUrl)!
        if let data = try? Data(contentsOf: url) {
            myImageView.image = UIImage(data: data)
        }
    }
}
