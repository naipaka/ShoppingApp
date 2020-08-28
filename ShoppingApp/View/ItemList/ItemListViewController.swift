//
//  ViewController.swift
//  ShoppingApp
//
//  Created by 小林遼太 on 2020/08/27.
//  Copyright © 2020 小林遼太. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ItemListViewController: UITableViewController, Injectable {
    typealias Dependency = ItemListViewModel
    private let viewModel: ItemListViewModel

    private let cartButton = UIBarButtonItem()
    private var dataSource = [Item]()

    private let disposeBag = DisposeBag()

    // MARK: - Injectable
    required init(with dependency: Dependency) {
        viewModel = dependency
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        onViewDidLoad()
    }

    // MARK: - private
    private func onViewDidLoad() {
        setup()
        bind()
    }

    private func setup() {
        navigationItem.leftBarButtonItem = cartButton
        tableView.tableFooterView = UIView()
        tableView.register(ItemCell.nib, forCellReuseIdentifier: ItemCell.reuseIdentifier)
    }

    private func bind() {
        rx.sentMessage(#selector(viewWillAppear(_:)))
            .map { _ in }
            .bind(to: viewModel.viewWillAppear)
            .disposed(by: disposeBag)

        cartButton.rx.tap
            .bind(to: viewModel.carButtonDidTap)
            .disposed(by: disposeBag)

        viewModel.title
            .bind(to: rx.title)
            .disposed(by: disposeBag)

        viewModel.cartButtonTitle
            .bind(to: cartButton.rx.title)
            .disposed(by: disposeBag)

        viewModel.items
            .bind { [weak self] items in
                self?.reloadData(items)}
            .disposed(by: disposeBag)

        viewModel.navigateToCart
            .bind { [weak self] in
                self?.navigationToCart()}
            .disposed(by: disposeBag)
    }

    private func reloadData(_ data: [Item]) {
        dataSource = data
        tableView.reloadData()
    }

    private func navigationToCart() {
        let viewController = CartViewController.make()
        let navigation = UINavigationController(
            rootViewController: viewController
        )
        present(navigation, animated: true)
    }
}

// MARK: - TableViewDataSource
extension ItemListViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? ItemCell else { return }
        cell.addedItem
            .bind(to: viewModel.addButtonDidTap)
            .disposed(by: cell.disposeBag)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = dataSource[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: ItemCell.reuseIdentifier) as! ItemCell
        cell.configure(item)
        return cell
    }
}
