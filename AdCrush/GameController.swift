///
/// GameController.swift
///

import Foundation
import RxSwift
import Realm

final class GameController {
  
  static let shared = GameController()
  
  var user = RealmController.user
  
  var openMenu: Variable<MenuItemType?> = Variable(nil)
  
  lazy var saleItems: [ForSaleItem] = {
    return self.loadForSaleItems()
  }()
  
  private init() {}

  func forSaleItems(for menuType: MenuItemType) -> [ForSaleItem] {
    return saleItems.filter { $0.itemType == menuType }
  }
  
  func buy(_ item: ForSaleItem) {
    guard let nextLevel = item.nextLevel else { return }
    user.buy(itemType: item.itemType, level: nextLevel)
  }
}


// MARK: - Menu Items
extension GameController {
  
  func loadForSaleItems() -> [ForSaleItem] {
    
    var items = [ForSaleItem]()
    
    var forSaleItem = ForSaleItem(itemType: .industry, name: "Food")
    var item = ItemLevel(price: 50, value: 200)
    var item2 = ItemLevel(price: 100, value: 300)
    var item3 = ItemLevel(price: 150, value: 400)
    [item, item2, item3].forEach { forSaleItem.levels.append($0) }
    items.append(forSaleItem)
    
    forSaleItem = ForSaleItem(itemType: .industry, name: "Cars")
    item = ItemLevel(price: 1000, value: 500)
    item2 = ItemLevel(price: 1500, value: 750)
    item3 = ItemLevel(price: 2000, value: 1000)
    [item, item2, item3].forEach { forSaleItem.levels.append($0) }
    items.append(forSaleItem)
    
    forSaleItem = ForSaleItem(itemType: .industry, name: "Drugs")
    item = ItemLevel(price: 5000, value: 1000)
    item2 = ItemLevel(price: 10000, value: 1250)
    item3 = ItemLevel(price: 25000, value: 1500)
    [item, item2, item3].forEach { forSaleItem.levels.append($0) }
    items.append(forSaleItem)
    
    forSaleItem = ForSaleItem(itemType: .industry, name: "Cigarettes")
    item = ItemLevel(price: 50000, value: 5000)
    item2 = ItemLevel(price: 100000, value: 10000)
    item3 = ItemLevel(price: 150000, value: 15000)
    [item, item2, item3].forEach { forSaleItem.levels.append($0) }
    items.append(forSaleItem)
    
    return items
  }
}
