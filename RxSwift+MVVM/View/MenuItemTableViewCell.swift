//
//  MenuItemTableViewCell.swift
//  RxSwift+MVVM
//
//  Created by iamchiwon on 07/08/2019.
//  Copyright © 2019 iamchiwon. All rights reserved.
//

import UIKit
import RxSwift

class MenuItemTableViewCell: UITableViewCell {
    @IBOutlet var title: UILabel!
    @IBOutlet var count: UILabel!
    @IBOutlet var price: UILabel!
    
    
    let onData: AnyObserver<Menu>
    var onCountChanged: (Int) -> Void
    var onChanged: Observable<Int>
    
    required init?(coder aDecoder: NSCoder) {
        
        let data = PublishSubject<Menu>()
        let changing = PublishSubject<Int>()
        onCountChanged = { changing.onNext($0) }

        onChanged = changing
        onData = data.asObserver()
        super.init(coder: aDecoder)
        
        data.observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] menu in
                self?.title.text = menu.name
                self?.price.text = "\(menu.price)"
                self?.count.text = "\(menu.count)"
            }).dispose()
        
        
    }

    @IBAction func onIncreaseCount() {
        onCountChanged(1)
    }

    @IBAction func onDecreaseCount() {
        onCountChanged(-1)
    }
}
