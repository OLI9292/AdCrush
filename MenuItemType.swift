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
  
  var title: String {
    switch self {
    case .industry:
      return "Upgrade Industry Type"
    case .medium:
      return "Upgrade Ad Type"
    case .investment:
      return  "Invest in the World"
      
      
    }
  }
  
  func subtitle(_ value: String) -> String {
    switch self {
    case .industry:
      return "Next: \(value) Karma / Crush"
    case .medium:
      return "Next: \(value)X Multiplier"
    case .investment:
      return "Next: \(value) Karma / Second"
      
    }
  }
}
