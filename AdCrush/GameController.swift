///
/// GameController.swift
///

import Foundation
import RxSwift
import Realm

final class GameController {
  
  static let shared = GameController()
  
  // Realm objects
  var saleItems = RealmController.saleItems
  var user = RealmController.user
  
  var openMenu: Variable<MenuItemType?> = Variable(nil)
  
  private init() {}

  func forSaleItems(for menuType: MenuItemType) -> [ForSaleItem] {
    return saleItems.filter { $0.itemType == menuType }
  }
}
