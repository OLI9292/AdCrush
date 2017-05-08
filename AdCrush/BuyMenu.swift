///
/// BuyMenu.swift
///

import UIKit

class BuyMenu: UIView {
  
  var menuItemType: MenuItemType
  
  init(_ menuItemType: MenuItemType, frame: CGRect) {
    self.menuItemType = menuItemType
    super.init(frame: frame)
    backgroundColor = .black
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
