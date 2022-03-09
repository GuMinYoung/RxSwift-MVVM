//
//  ViewController.swift
//  RxSwift+MVVM
//
//  Created by iamchiwon on 05/08/2019.
//  Copyright © 2019 iamchiwon. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MenuViewController: UIViewController {
    // MARK: - Life Cycle
    
    let viewModel = MenuListViewModel()
    var disposeBag = DisposeBag()
    let cellID = "MenuItemTableViewCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.menuObservable
            .observeOn(MainScheduler.instance)
            .bind(to: tableView.rx.items(cellIdentifier: cellID, cellType: MenuItemTableViewCell.self)) { index, item, cell in
            cell.title.text = item.name
            cell.price.text = "\(item.price)"
            cell.count.text = "\(item.count)"
        }.disposed(by: disposeBag)
        
        viewModel.itemsCount
            .observeOn(MainScheduler.instance)
            .map { "\($0)" }
            .bind(to: itemCountLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.totalPrice
            .observeOn(MainScheduler.instance)
            .map { $0.currencyKR() }
            .bind(to: totalPrice.rx.text)
            .disposed(by: disposeBag)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let identifier = segue.identifier ?? ""
        if identifier == "OrderViewController",
            let orderVC = segue.destination as? OrderViewController {
            // TODO: pass selected menus
        }
    }

    func showAlert(_ title: String, _ message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertVC, animated: true, completion: nil)
    }

    // MARK: - InterfaceBuilder Links

    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var itemCountLabel: UILabel!
    @IBOutlet var totalPrice: UILabel!

    @IBAction func onClear() {
    }

    @IBAction func onOrder(_ sender: UIButton) {
        // TODO: no selection
        // showAlert("Order Fail", "No Orders")
        //performSegue(withIdentifier: "OrderViewController", sender: nil)
        
        viewModel.menuObservable.onNext([
            Menu(name: "menu", price: Int.random(in: 100...1000), count: Int.random(in: 0...3)),
            Menu(name: "menu", price: Int.random(in: 100...1000), count: Int.random(in: 0...3)),
            Menu(name: "menu", price: Int.random(in: 100...1000), count: Int.random(in: 0...3))
        ])
    }
}
