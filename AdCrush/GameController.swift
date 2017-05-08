///
/// GameController.swift
///

import Foundation
import RxSwift

final class GameController {
  
  static let shared = GameController()
  
  var openMenu: Variable<MenuItemType?> = Variable(nil)
  
  lazy var saleItems: [ForSaleItem] = {
    return self.loadForSaleItems()
  }()
  
  private init() {}
  
  func currentUser() -> Observable<User> {
    // Placeholder
    return Observable.just(
      User(karma: 10, valuePerKrush: 10, multiplierPerKrush: 1, karmaPerSecond: 0)
    )
  }
  
  func forSaleItems(for menuType: MenuItemType) -> [ForSaleItem] {
    return saleItems.filter { $0.itemType == menuType }
  }
}


// MARK: - Menu Items
extension GameController {
  
  func loadForSaleItems() -> [ForSaleItem] {
    var items: [ForSaleItem] = []
    
    items.append(ForSaleItem(itemType: .industry, name: "Food", value: 200, cost: 0))
    items.append(ForSaleItem(itemType: .industry, name: "Cars", value: 1000, cost: 0))
    items.append(ForSaleItem(itemType: .industry, name: "Drugs", value: 5000, cost: 0))
    items.append(ForSaleItem(itemType: .industry, name: "Cigarettes", value: 50000, cost: 0))
    
    items.append(ForSaleItem(itemType: .medium, name: "Phone", value: 1000, cost: 0))
    items.append(ForSaleItem(itemType: .medium, name: "TV", value: 10000, cost: 0))
    items.append(ForSaleItem(itemType: .medium, name: "Subway", value: 20000, cost: 0))
    items.append(ForSaleItem(itemType: .medium, name: "Highway", value: 500000, cost: 0))
    
    items.append(ForSaleItem(itemType: .investment, name: "Save the Whales", value: 1000, cost: 0))
    items.append(ForSaleItem(itemType: .investment, name: "Cancer Research", value: 10000, cost: 0))
    items.append(ForSaleItem(itemType: .investment, name: "Internet Freedom", value: 20000, cost: 0))
    items.append(ForSaleItem(itemType: .investment, name: "Universal Basic Income", value: 500000, cost: 0))
    
    return items
  }
}
