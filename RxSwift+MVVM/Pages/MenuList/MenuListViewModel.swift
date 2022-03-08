//
//  MenuListViewModel.swift
//  RxSwift+MVVM
//
//  Created by 구민영 on 2022/03/08.
//  Copyright © 2022 iamchiwon. All rights reserved.
//

import Foundation

class MenuListViewModel {
    var menus: [Menu] = [
        Menu(name: "튀김1", price: 200, count: 0),
        Menu(name: "튀김1", price: 200, count: 0),
        Menu(name: "튀김1", price: 200, count: 0),
        Menu(name: "튀김1", price: 200, count: 0)
    ]
    
    var itemsCount = 5
    var totalPrice = 10_000
}
