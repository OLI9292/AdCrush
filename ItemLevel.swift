///
/// ItemLevel.swift
///

import Foundation
import RealmSwift

class ItemLevel: Object, Comparable {
  
  dynamic var price: Float = 0
  dynamic var purchased: Bool = false
  dynamic var value: Float = 0
  
  convenience init(price: Float, value: Float, purchased: Bool = false) {
    self.init()
    self.price = price
    self.value = value
    self.purchased = purchased
  }
}

func ==(lhs: ItemLevel, rhs: ItemLevel) -> Bool {
  return lhs.value == rhs.value
}

func <(lhs: ItemLevel, rhs: ItemLevel) -> Bool {
  return lhs.value < rhs.value
}
