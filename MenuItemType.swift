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
  
  func subTitle(for value: String) -> String {
    switch self {
    case .invest:
      return "x\(value)"
    case .recruits:
      return "+\(value)"
    case .gear:
      return "+\(value)"
    default:
      return ""
    }
  }
}
