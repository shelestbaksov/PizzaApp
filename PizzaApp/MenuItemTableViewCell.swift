//
//  MenuItemTableViewCell.swift
//  PizzaApp
//
//  Created by Leysan Latypova on 18.10.2022.
//

import UIKit

class MenuItemTableViewCell: UITableViewCell {
    static let identifier = "MenuItemTableViewCell"
    
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemTitleLabel: UILabel!
    @IBOutlet weak var itemDescriptionLabel: UILabel!
    @IBOutlet weak var itemPriceLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
