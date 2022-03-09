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
    var menus: [Menu] = [
        Menu(name: "튀김1", price: 200, count: 0),
        Menu(name: "튀김1", price: 200, count: 0),
        Menu(name: "튀김1", price: 200, count: 0),
        Menu(name: "튀김1", price: 200, count: 0)
    ]
    
    var itemsCount = 5
    // just
    // 1만원이라는 값을 subscribe해서 받을 수 있도록 하나의 요소만을 방출하는 observable을 생성
    //var totalPrice: Observable<Int> = Observable.just(10_000)
    
    // PublishSubject
    // 이미 만들어진 observable 밖에서 새로운 데이터를 생성(OnNext)할 수 있음
    var totalPrice: PublishSubject<Int> = PublishSubject()
}
