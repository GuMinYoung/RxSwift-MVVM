//
//  MenuListViewModel.swift
//  RxSwift+MVVM
//
//  Created by 구민영 on 2022/03/08.
//  Copyright © 2022 iamchiwon. All rights reserved.
//

import Foundation
import RxSwift

class MenuListViewModel {
    // Subject
    // 이미 만들어진 observable 밖에서 새로운 데이터를 생성(OnNext)할 수 있음
    var menuObservable = BehaviorSubject<[Menu]>(value: [])
    
    lazy var itemsCount = menuObservable.map { menus in
        menus.map { $0.count }.reduce(0, +)
    }
    
    lazy var totalPrice = menuObservable.map { menus in
        menus.map { $0.price * $0.count }.reduce(0, +)
    }
    
    init() {
        let menus: [Menu] = [
            Menu(name: "튀김1", price: 200, count: 0),
            Menu(name: "튀김1", price: 200, count: 0),
            Menu(name: "튀김1", price: 200, count: 0),
            Menu(name: "튀김1", price: 200, count: 0)
        ]
        
        menuObservable.onNext(menus)
    }
    
    func clearAllItemSelections() {
        _ = menuObservable.map { menus in
            menus.map { Menu(name: $0.name, price: $0.price, count: 0)
            }
        }.take(1)   // 1개 아이템만 방출
        .subscribe(onNext: {
            // 바뀐 메뉴를 다시 menuObservable에 넣어줌
            self.menuObservable.onNext($0)
        })
    }
}
