///
/// ForSaleItem.swift
///

import Foundation
import RealmSwift

typealias ItemAttributes = (price: Float, value: Float)

class ForSaleItem: Object {
  
  dynamic var itemTypeString: String = ""
  dynamic var name: String = ""
  var levels = List<ItemLevel>()
  
  var itemType: MenuItemType {
    return MenuItemType(rawValue: itemTypeString)!
  }
  
  var nextLevel: ItemAttributes? {
    guard let level = levels.sorted().first(where: { !$0.purchased }) else { return nil }
    return (level.price, level.value)
  }
  
  convenience init(itemType: MenuItemType, name: String) {
    self.init()
    self.itemTypeString = itemType.rawValue
    self.name = name
  }
}
