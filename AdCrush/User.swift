///
/// User.swift
///

import Realm
import RealmSwift

class User: Object {
  
  dynamic var karma: Float = 0
  dynamic var karmaPerSecond: Float = 0
  dynamic var multiplierPerCrush: Float = 1
  dynamic var valuePerCrush: Float = 1
  
  func buy(itemType: MenuItemType, level: ItemAttributes) {

    RealmController.spend(user: self, price: level.price)

    switch itemType {
    case .industry:
      RealmController.increase(valuePerCrush: level.value)
    case .investment:
      RealmController.increase(karmaPerSecond: level.value)
    case .medium:
      RealmController.increase(multiplierPerCrush: level.value)
    }
  }
}


