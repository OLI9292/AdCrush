///
/// User.swift
///

import Realm
import RealmSwift

class User: Object {
  
  dynamic var karma: Float = 100000
  dynamic var karmaPerSecond: Float = 0
  dynamic var multiplierPerCrush: Float = 1
  dynamic var valuePerCrush: Float = 1
  
  func buy(item: ForSaleItem) {
    guard let price = item.nextLevel?.price, let value = item.nextLevel?.value else { return }
    
    RealmController.spend(user: self, price: price)
    RealmController.itemBought(item)

    switch item.itemType {
    case .industry:
      RealmController.increase(valuePerCrush: value)
    case .investment:
      RealmController.increase(karmaPerSecond: value)
    case .medium:
      RealmController.increase(multiplierPerCrush: value)
    }
  }
}
