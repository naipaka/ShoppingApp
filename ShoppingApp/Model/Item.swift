//
//  Item.swift
//  ShoppingApp
//
//  Created by 小林遼太 on 2020/08/27.
//  Copyright © 2020 小林遼太. All rights reserved.
//

import Foundation

struct Item: Equatable, Codable {
    let id: Int
    let price: Int
    let title: String
    let imageUrl: URL
}
