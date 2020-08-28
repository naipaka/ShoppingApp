//
//  ItemCell.swift
//  ShoppingApp
//
//  Created by 小林遼太 on 2020/08/28.
//  Copyright © 2020 小林遼太. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ItemCell: UITableViewCell, NibInstantiable, Reusable {
    typealias Value = Item

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var inventoryLabel: UILabel!

    private let addedItemStream = PublishRelay<Item>()

    var disposeBag = DisposeBag()

    private var value: Value? {
        didSet {
            titleLabel.text = value?.title

            if let price = value?.price {
                priceLabel.text = "\(price)円+税"
            } else {
                priceLabel.text = "-"
            }

            if let url = value?.imageUrl {
                let urlRequest = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad)
                URLSession.shared.rx.data(request: urlRequest)
                    .map { UIImage(data: $0) }
                    .bind(to: itemImageView.rx.image)
                    .disposed(by: disposeBag)
            }
        }
    }

    func configure(_ value: Value) {
        self.value = value

        actionButton.rx.tap
            .map { value }
            .bind(to: addedItemStream)
            .disposed(by: disposeBag)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
}

// MARK: - Output
extension ItemCell {
    var addedItem: Observable<Item> {
        return addedItemStream.asObservable()
    }
}
