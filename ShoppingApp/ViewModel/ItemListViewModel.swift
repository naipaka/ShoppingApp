//
//  ItemListViewModel.swift
//  ShoppingApp
//
//  Created by 小林遼太 on 2020/08/27.
//  Copyright © 2020 小林遼太. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class ItemListViewModel: Injectable {
    struct Dependency {
        let apiClient: APIClient
    }

    private let viewWillAppearStream = PublishSubject<()>()
    private let cartButtonDidTapStream = PublishSubject<()>()
    private let addItemDidTapStream = PublishSubject<Item>()
    private let itemsStream = BehaviorSubject<[Item]>(value: [])
    private let navigateToCartStream = PublishSubject<()>()

    private let disposeBag = DisposeBag()

    // MARK: - Injectable
    init(with dependency: Dependency) {
        // APIクライアントをDIパターンを利用して取得
        let apiClient = dependency.apiClient
        // 画面表示イベントを商品リストデータに変換
        viewWillAppearStream
            .flatMapLatest{ _ -> Observable<[Item]> in
                let request = API.ItemListRequest()
                return apiClient.response(from: request)
        }
        .bind(to: itemsStream)
        .disposed(by: disposeBag)

        cartButtonDidTapStream
            .bind(to: navigateToCartStream)
            .disposed(by: disposeBag)
    }
}

// MARK: - Input
extension ItemListViewModel {
    var viewWillAppear: AnyObserver<()> {
        return viewWillAppearStream.asObserver()
    }

    var carButtonDidTap: AnyObserver<()> {
        return cartButtonDidTapStream.asObserver()
    }

    var addButtonDidTap: AnyObserver<Item> {
        return addItemDidTapStream.asObserver()
    }
}

// MARK: - Output
extension ItemListViewModel {
    var title: Observable<String> {
        return Observable.just("商品リスト")
    }

    var cartButtonTitle: Observable<String> {
        return Observable.just("カート")
    }

    var items: Observable<[Item]> {
        return itemsStream.asObservable()
    }

    var navigateToCart: Observable<()> {
        return navigateToCartStream.asObservable()
    }
}
