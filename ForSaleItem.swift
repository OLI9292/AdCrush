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
  
  var currentLevelText: String {
    guard
      let level = nextLevel,
      let levelNumber = levels.sorted().index(of: level)
      else { return "\(levels.count)/\(levels.count)" }
    return "\(levelNumber)/\(levels.count)"
  }
  
  var isComplete: Bool {
    return nextLevel == nil
  }
  
  convenience init(itemType: MenuItemType, name: String) {
    self.init()
    self.itemTypeString = itemType.rawValue
    self.name = name
  }
}
