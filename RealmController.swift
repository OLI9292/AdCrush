///
// RealmController.swift
///

import Realm
import RealmSwift

final class RealmController {
  
  static let shared = RealmController()
  
  private let db = try! Realm()
  
  private init() {}
  
  static var user: User {
    return shared.db.objects(User.self).first ?? shared.createUser()
  }
  
  static var saleItems: Results<ForSaleItem> {
    let _items = shared.db.objects(ForSaleItem.self)
    return _items.isEmpty ? shared.loadforSaleItems() : _items
  }
  
  private func createUser() -> User {
    try! db.write {
      db.add(User())
    }
    return RealmController.user
  }
  
  static func increase(karmaPerSecond: Float) {
    try! shared.db.write {
      user.karmaPerSecond = user.karmaPerSecond + karmaPerSecond
    }
  }
  
  static func increase(multiplierPerCrush: Float) {
    try! shared.db.write {
      user.multiplierPerCrush = user.multiplierPerCrush + multiplierPerCrush
    }
  }
  
  static func itemBought(_ item: ForSaleItem) {
    guard let level = item.nextLevel else { return }
    try! shared.db.write {
      shared.db.delete(level)
    }
  }
  
  static func increase(valuePerCrush: Float) {
    try! shared.db.write {
      user.valuePerCrush = user.valuePerCrush + valuePerCrush
    }
  }
  
  static func save(user: User) {
    try! shared.db.write {
      shared.db.add(user)
    }
  }
  
  static func save(items: [ForSaleItem]) {
    for item in items {
      try! shared.db.write {
        shared.db.add(item)
      }
    }
  }
  
  static func spend(user: User, price: Float) {
    try! shared.db.write {
      user.karma = user.karma - price
    }
  }
  
  // Seed
  
  static func seed() {
    try! shared.db.write {
      shared.db.delete(RealmController.user)
    }
    let items = RealmController.saleItems
    try! shared.db.write {
      shared.db.delete(items)
    }
  }
}


// MARK: - Data Loader
private typealias DataLoader = RealmController
extension DataLoader {
  
  func loadforSaleItems() -> Results<ForSaleItem> {
    
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
    
    RealmController.save(items: items)
    return RealmController.saleItems
  }
}
