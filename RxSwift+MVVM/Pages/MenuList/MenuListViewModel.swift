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
        _ = APIService.fetchAllMenusRx()
            .map { data -> [MenuItem] in
            struct Response: Decodable {
                var menus: [MenuItem]
            }
            
            let response = try! JSONDecoder().decode(Response.self, from: data)
            
            return response.menus
        }
        .map { menuItems -> [Menu] in
            var menus = [Menu]()
            menuItems.enumerated().forEach { (index, item) in
                let menu = Menu.fromMenuItem(id: index, item: item)
                menus.append(menu)
            }
            return menus
        }
        .take(1)
        .bind(to: menuObservable)
    }
    
    func clearAllItemSelections() {
        _ = menuObservable.map { menus in
            menus.map { Menu(id: $0.id, name: $0.name, price: $0.price, count: 0)
            }
        }.take(1)   // 1개 아이템만 방출
        .subscribe(onNext: {
            // 바뀐 메뉴를 다시 menuObservable에 넣어줌
            self.menuObservable.onNext($0)
        })
    }
    
    func changeCount(item: Menu, increase: Int) {
        _ = menuObservable
            .map { menus in
            menus.map {
                if item.id == $0.id {
                    return Menu(id: $0.id, name: $0.name, price: $0.price, count: max($0.count + increase, 0))
                } else {
                    return Menu(id: $0.id, name: $0.name, price: $0.price, count: $0.count)
                }
            }
        }.take(1)   // 1개 아이템만 방출
        .subscribe(onNext: {
            // 바뀐 메뉴를 다시 menuObservable에 넣어줌
            self.menuObservable.onNext($0)
        })
    }
}
