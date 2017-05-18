///
/// MenuItemType.swift
///

import UIKit

enum MenuItemType: String {
  case map, invest, recruits, gear, karmaPool
  
  static var menuItems: [MenuItemType] = [.map, .invest, .recruits, .gear, .karmaPool]
  
  var title: String {
    switch self {
    case .map, .invest, .recruits, .gear:
      return rawValue.uppercased()
    case .karmaPool:
      return "POOL"
    }
  }
  
  var image: UIImage {
    switch self {
    case .map:
      return #imageLiteral(resourceName: "WORLD-FPO")
    case .invest:
      return #imageLiteral(resourceName: "INVEST-FPO")
    case .recruits:
      return #imageLiteral(resourceName: "RECRUITS-FPO")
    case .gear:
      return #imageLiteral(resourceName: "GEAR-FPO")
    case .karmaPool:
      return #imageLiteral(resourceName: "KARMAPOOL-FPO")
    }
  }
  
  func subTitle(for value: String) -> String {
    switch self {
    case .invest:
      return "+\(value)/s"
    case .recruits:
      return "+\(value)"
    case .gear:
      return "+\(value)/crush"
    default:
      return ""
    }
  }
}
