//
//  CartItem.swift
//  ShoppingApp
//
//  Created by 小林遼太 on 2020/08/28.
//  Copyright © 2020 小林遼太. All rights reserved.
//

import Foundation

struct CartItem {
    var item: Item
    var quantity: Int

    mutating func increase() {
        quantity += 1
    }

    mutating func decrease() {
        quantity = max(0, quantity - 1)
    }
}
