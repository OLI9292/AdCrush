///
/// ForSaleItem.swift
///

import Foundation
import RealmSwift

class ForSaleItem: Object {
  
  dynamic var itemTypeString: String = ""
  dynamic var name: String = ""
  var levels = List<ItemLevel>()
  
  var itemType: MenuItemType {
    return MenuItemType(rawValue: itemTypeString)!
  }
  
  var nextLevel: ItemLevel? {
    return levels.sorted().first(where: { !$0.purchased })
  }
  
  convenience init(itemType: MenuItemType, name: String) {
    self.init()
    self.itemTypeString = itemType.rawValue
    self.name = name
  }
}
