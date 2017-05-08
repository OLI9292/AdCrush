///
/// MenuItemType.swift
///

import UIKit

enum MenuItemType: String {
  case investment, industry, medium
  
  static var menuItems: [(type: MenuItemType, image: UIImage)] {
    return [
      (.industry, #imageLiteral(resourceName: "industry")),
      (.medium, #imageLiteral(resourceName: "medium")),
      (.investment, #imageLiteral(resourceName: "investment"))
    ]
  }
}
