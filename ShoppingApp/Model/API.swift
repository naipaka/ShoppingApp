//
//  API.swift
//  ShoppingApp
//
//  Created by 小林遼太 on 2020/08/27.
//  Copyright © 2020 小林遼太. All rights reserved.
//

import Foundation
import RxSwift

protocol APIRequest {
    associatedtype Response
    var path: String { get }
}

protocol APIClient {
    func response<Request: APIRequest>(from request: Request) -> Observable<Request.Response>
}

enum API {
    struct ItemListRequest: APIRequest {
        typealias Response = [Item]
        var path: String {
            return "items/list"
        }
    }
}
