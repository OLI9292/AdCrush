///
/// ItemLevel.swift
///

import Foundation
import RealmSwift

class ItemLevel: Object, Comparable {
  
  dynamic var cost: Int = 0
  dynamic var purchased: Bool = false
  dynamic var value: Int = 0
  
  convenience init(cost: Int, value: Int, purchased: Bool = false) {
    self.init()
    self.cost = cost
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
