///
/// Palette.swift
///

import Foundation

import UIKit

enum Palette {
  
  case
  blue,
  green,
  orange,
  purple,
  red,
  yellow,
  white,
  // Custom
  darkGrey,
  lightGrey,
  lighterGrey,
  // Transparent
  transparent
  // Background
  
  var color: UIColor {
    switch self {
    case .blue:
      return UIColor(hex: 0x0000FF)
    case .green:
      return UIColor(hex: 0x00FF00)
    case .orange:
      return UIColor(hex: 0xFF7F00)
    case .purple:
      return UIColor(hex: 0x4B0082)
    case .red:
      return UIColor(hex: 0xFF0000)
    case .yellow:
      return UIColor(hex: 0xFFFF00)
    case .white:
      return UIColor(hex: 0xFFFFFF)
    // Custom
    case .darkGrey:
      return UIColor(hex: 0x4A4A4A)
    case .lightGrey:
      return UIColor(hex: 0xC4C4C4)
    case .lighterGrey:
      return UIColor(hex: 0xE0E0E0)
    // Transparent
    case .transparent:
      return UIColor(white: 1, alpha: 0.0)
    }
  }
}

extension UIColor {
  
  static let colors = [Palette.purple.color, Palette.blue.color, Palette.green.color, Palette.yellow.color, Palette.orange.color, Palette.red.color, Palette.purple.color, Palette.blue.color, Palette.green.color ]
  
  convenience init(hex: Int) {
    let components = (
      R: CGFloat((hex >> 16) & 0xff) / 255,
      G: CGFloat((hex >> 08) & 0xff) / 255,
      B: CGFloat((hex >> 00) & 0xff) / 255
    )
    self.init(red: components.R, green: components.G, blue: components.B, alpha: 1)
  }
  
  class func forGradient(_ red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
    return UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: 1.0)
  }
}
