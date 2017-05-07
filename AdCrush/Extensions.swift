///
/// Extensions.swift
///

import Foundation
import UIKit

extension Int {
  func asMaxRandom() -> Int {
    return Int(arc4random_uniform(UInt32(self))) + 1
  }
}

func randomBetween(_ first: Float, and second: Float) -> Float {
  return Float(arc4random()) / Float(UINT32_MAX) * abs(first - second) + min(first, second)
}


// MARK: - UIKit
extension UIView {
  func freeConstraints() {
    translatesAutoresizingMaskIntoConstraints = false
  }
}
