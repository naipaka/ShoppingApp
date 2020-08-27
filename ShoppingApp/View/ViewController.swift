//
//  ViewController.swift
//  ShoppingApp
//
//  Created by 小林遼太 on 2020/08/27.
//  Copyright © 2020 小林遼太. All rights reserved.
//

import UIKit

class ViewController: UIViewController, Injectable {
    typealias Dependency = APIClient
    private let apiClient: APIClient

    required init(with dependency: Dependency) {
        apiClient = dependency
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

