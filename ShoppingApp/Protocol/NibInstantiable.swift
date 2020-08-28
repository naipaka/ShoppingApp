//
//  NibInstantiable.swift
//  ShoppingApp
//
//  Created by 小林遼太 on 2020/08/28.
//  Copyright © 2020 小林遼太. All rights reserved.
//

import UIKit

protocol NibInstantiable {
    static var nib: UINib { get }
}

extension NibInstantiable {
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
}
