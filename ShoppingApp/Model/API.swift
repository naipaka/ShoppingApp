//
//  API.swift
//  ShoppingApp
//
//  Created by 小林遼太 on 2020/08/27.
//  Copyright © 2020 小林遼太. All rights reserved.
//

import Foundation

protocol APIRequest {
    associatedtype Response
}

protocol APIClient {
    func response<R: APIRequest>(
        from request: R,
        completion: ((R.Response) -> ())?
    )
}

class SomeAPIClient {
    func request() {

    }
}
