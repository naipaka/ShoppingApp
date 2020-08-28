//
//  CartHeaderView.swift
//  ShoppingApp
//
//  Created by 小林遼太 on 2020/08/28.
//  Copyright © 2020 小林遼太. All rights reserved.
//

import UIKit

final class CartHeaderView: UIView, NibInstantiable {

    @IBOutlet private weak var priceLabel: UILabel!

    static func make() -> CartHeaderView {
        let view = CartHeaderView.nib.instantiate(withOwner: nil, options: nil)[0] as! CartHeaderView
        return view
    }

    func configure(_ totalPrice: String) {
        self.priceLabel.text = totalPrice
    }
}
