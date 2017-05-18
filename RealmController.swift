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
    return shared.db.objects(User.self).first!
  }
  
  static var saleItems: Results<ForSaleItem> {
    return shared.db.objects(ForSaleItem.self)
  }
  
  private func createUser() {
    try! db.write {
      db.add(User())
    }
  }
  
  static func gain(karma: Float) {
    try! shared.db.write {
      user.karma += karma
    }
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
      level.purchased = true
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
    // Delete
    deleteUser()
    deleteForSaleItems()
    // Load
    RealmController.save(items: DataLoader.forSaleItemsSeed)
    RealmController.shared.createUser()
  }
  
  // Delete
  
  static func deleteUser() {
    if let user = shared.db.objects(User.self).first {
      try! shared.db.write {
        shared.db.delete(user)
      }
    }
  }
  
  static func deleteForSaleItems() {
    let items = shared.db.objects(ForSaleItem.self)
    try! shared.db.write {
      shared.db.delete(items)
    }
  }
}


// MARK: - Data Loader
private typealias DataLoader = RealmController
extension DataLoader {
  
  static var forSaleItemsSeed: [ForSaleItem] {
    
    var items = [ForSaleItem]()

    var forSaleItem = ForSaleItem(itemType: .invest, name: "Save the Whales")
    var item = ItemLevel(price: 100, value: 10)
    var item2 = ItemLevel(price: 100, value: 10)
    var item3 = ItemLevel(price: 150, value: 10)
    [item, item2, item3].forEach { forSaleItem.levels.append($0) }
    items.append(forSaleItem)
    
    forSaleItem = ForSaleItem(itemType: .invest, name: "Internet Freedom")
    item = ItemLevel(price: 200, value: 20)
    item2 = ItemLevel(price: 1500, value: 20)
    item3 = ItemLevel(price: 2000, value: 20)
    [item, item2, item3].forEach { forSaleItem.levels.append($0) }
    items.append(forSaleItem)
    
    forSaleItem = ForSaleItem(itemType: .invest, name: "Black Lives Matter")
    item = ItemLevel(price: 500, value: 40)
    item2 = ItemLevel(price: 10000, value: 40)
    item3 = ItemLevel(price: 25000, value: 40)
    [item, item2, item3].forEach { forSaleItem.levels.append($0) }
    items.append(forSaleItem)
    
    forSaleItem = ForSaleItem(itemType: .invest, name: "Human Rights Watch")
    item = ItemLevel(price: 1000, value: 80)
    item2 = ItemLevel(price: 100000, value: 80)
    item3 = ItemLevel(price: 150000, value: 80)
    [item, item2, item3].forEach { forSaleItem.levels.append($0) }
    items.append(forSaleItem)
    
    forSaleItem = ForSaleItem(itemType: .invest, name: "Union of Concerned Scientists")
    item = ItemLevel(price: 2000, value: 160)
    item2 = ItemLevel(price: 100000, value: 160)
    item3 = ItemLevel(price: 150000, value: 160)
    [item, item2, item3].forEach { forSaleItem.levels.append($0) }
    items.append(forSaleItem)
    
    forSaleItem = ForSaleItem(itemType: .invest, name: "Universal Basic Income")
    item = ItemLevel(price: 5000, value: 320)
    item2 = ItemLevel(price: 100000, value: 320)
    item3 = ItemLevel(price: 150000, value: 320)
    [item, item2, item3].forEach { forSaleItem.levels.append($0) }
    items.append(forSaleItem)
    
    
    forSaleItem = ForSaleItem(itemType: .recruits, name: "Clubhouse")
    item = ItemLevel(price: 50, value: 2)
    item2 = ItemLevel(price: 100, value: 3)
    item3 = ItemLevel(price: 150, value: 4)
    [item, item2, item3].forEach { forSaleItem.levels.append($0) }
    items.append(forSaleItem)
    
    forSaleItem = ForSaleItem(itemType: .recruits, name: "Headquarters")
    item = ItemLevel(price: 1000, value: 5)
    item2 = ItemLevel(price: 1500, value: 7)
    item3 = ItemLevel(price: 2000, value: 10)
    [item, item2, item3].forEach { forSaleItem.levels.append($0) }
    items.append(forSaleItem)
    
    forSaleItem = ForSaleItem(itemType: .recruits, name: "Library")
    item = ItemLevel(price: 5000, value: 100)
    item2 = ItemLevel(price: 10000, value: 125)
    item3 = ItemLevel(price: 25000, value: 150)
    [item, item2, item3].forEach { forSaleItem.levels.append($0) }
    items.append(forSaleItem)
    
    forSaleItem = ForSaleItem(itemType: .recruits, name: "VPN")
    item = ItemLevel(price: 50000, value: 500)
    item2 = ItemLevel(price: 100000, value: 1000)
    item3 = ItemLevel(price: 150000, value: 1500)
    [item, item2, item3].forEach { forSaleItem.levels.append($0) }
    items.append(forSaleItem)
    
    
    
    forSaleItem = ForSaleItem(itemType: .gear, name: "Mask")
    item = ItemLevel(price: 50, value: 0.6)
    item2 = ItemLevel(price: 150, value: 0.6)
    item3 = ItemLevel(price: 200, value: 0.6)
    [item, item2, item3].forEach { forSaleItem.levels.append($0) }
    items.append(forSaleItem)
    
    forSaleItem = ForSaleItem(itemType: .gear, name: "Subway Pass")
    item = ItemLevel(price: 1000, value: 1.2)
    item2 = ItemLevel(price: 1500, value: 1.2)
    item3 = ItemLevel(price: 2000, value: 1.2)
    [item, item2, item3].forEach { forSaleItem.levels.append($0) }
    items.append(forSaleItem)
    
    forSaleItem = ForSaleItem(itemType: .gear, name: "Minivan")
    item = ItemLevel(price: 5000, value: 2.4)
    item2 = ItemLevel(price: 7500, value: 2.4)
    item3 = ItemLevel(price: 10000, value: 2.4)
    [item, item2, item3].forEach { forSaleItem.levels.append($0) }
    items.append(forSaleItem)
    
    forSaleItem = ForSaleItem(itemType: .gear, name: "Helicopter")
    item = ItemLevel(price: 10000, value: 4.8)
    item2 = ItemLevel(price: 15000, value: 4.8)
    item3 = ItemLevel(price: 20000, value: 4.8)
    [item, item2, item3].forEach { forSaleItem.levels.append($0) }
    items.append(forSaleItem)

    return items
  }
}
