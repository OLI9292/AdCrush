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
  
  func subtitle(_ value: String) -> String {
    switch self {
    case .industry:
      return "Next: \(value)/Crush"
    case .investment:
      return "Next: \(value)/Multiplier"
    case .medium:
      return "Next: \(value) K/s"
    }
  }
}
