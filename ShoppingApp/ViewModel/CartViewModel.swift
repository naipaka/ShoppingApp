//
//  CartViewModel.swift
//  ShoppingApp
//
//  Created by 小林遼太 on 2020/08/28.
//  Copyright © 2020 小林遼太. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class CartViewModel: Injectable {
    typealias Dependency = Void

    private let closeButtonDidTapStream = PublishSubject<()>()
    private let dismissStream = PublishSubject<()>()

    private let disposeBag = DisposeBag()

    // MARK: - injectable
    init(with dependency: Dependency) {
        closeButtonDidTapStream
            .bind(to: dismissStream)
            .disposed(by: disposeBag)
    }
}

// MARK: - Input
extension CartViewModel{
    var closeButtonDidTap: AnyObserver<()> {
        return closeButtonDidTapStream.asObserver()
    }
}

// MARK: - Output
extension CartViewModel {
    var title: Observable<String> {
        return Observable.just("カート")
    }

    var closeButtonTitle: Observable<String> {
        return Observable.just("閉じる")
    }
    
    var dismiss: Observable<()> {
        return dismissStream.asObserver()
    }
}
