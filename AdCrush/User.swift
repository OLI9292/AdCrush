///
/// User.swift
///

import Realm
import RealmSwift

class User: Object {
  
  dynamic var karma: Float = 10000
  
  dynamic var karmaPerSecond: Float = 0
  dynamic var karmaPerFrame: Float {
    return Float(karmaPerSecond / 60.0)
  }
  
  dynamic var multiplierPerCrush: Float = 1
  dynamic var valuePerCrush: Float = 1
  
  dynamic var totalKarmaPerCrush: Float {
    return valuePerCrush * multiplierPerCrush
  }
  
  
  func buy(item: ForSaleItem) {
    guard let price = item.nextLevel?.price, let value = item.nextLevel?.value else { return }
    
    RealmController.spend(user: self, price: price)
    RealmController.itemBought(item)

    switch item.itemType {
    default:
      print("bought something")
    }
  }
  
  func gain(karma: Float) {
    RealmController.gain(karma: karma)
  }
}
