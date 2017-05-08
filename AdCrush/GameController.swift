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
      User(karma: 100, valuePerKrush: 10, multiplierPerKrush: 1, karmaPerSecond: 0)
    )
  }

  func forSaleItems(for menuType: MenuItemType) -> [ForSaleItem] {
    return saleItems.filter { $0.itemType == menuType }
  }
}


// MARK: - Menu Items
extension GameController {
  
  func loadForSaleItems() -> [ForSaleItem] {
    
    var items = [ForSaleItem]()
    
    var forSaleItem = ForSaleItem(itemType: .industry, name: "Food")
    var item = ItemLevel(cost: 50, value: 200)
    var item2 = ItemLevel(cost: 100, value: 300)
    var item3 = ItemLevel(cost: 150, value: 400)
    [item, item2, item3].forEach { forSaleItem.levels.append($0) }
    items.append(forSaleItem)
    
    forSaleItem = ForSaleItem(itemType: .industry, name: "Cars")
    item = ItemLevel(cost: 1000, value: 500)
    item2 = ItemLevel(cost: 1500, value: 750)
    item3 = ItemLevel(cost: 2000, value: 1000)
    [item, item2, item3].forEach { forSaleItem.levels.append($0) }
    items.append(forSaleItem)
    
    forSaleItem = ForSaleItem(itemType: .industry, name: "Drugs")
    item = ItemLevel(cost: 5000, value: 1000)
    item2 = ItemLevel(cost: 10000, value: 1250)
    item3 = ItemLevel(cost: 25000, value: 1500)
    [item, item2, item3].forEach { forSaleItem.levels.append($0) }
    items.append(forSaleItem)
    
    forSaleItem = ForSaleItem(itemType: .industry, name: "Cigarettes")
    item = ItemLevel(cost: 50000, value: 5000)
    item2 = ItemLevel(cost: 100000, value: 10000)
    item3 = ItemLevel(cost: 150000, value: 15000)
    [item, item2, item3].forEach { forSaleItem.levels.append($0) }
    items.append(forSaleItem)
    
    return items
  }
}
