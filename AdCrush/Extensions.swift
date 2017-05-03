///
/// Extensions.swift
///

import Foundation
import SpriteKit

extension Int {
  func asMaxRandom() -> Int {
    return Int(arc4random_uniform(UInt32(self))) + 1
  }
}

func randomBetween(_ first: Float, and second: Float) -> Float {
  return Float(arc4random()) / Float(UINT32_MAX) * abs(first - second) + min(first, second)
}
