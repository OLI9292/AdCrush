///
/// Extensions.swift
///

import Foundation

extension Int {
  func asMaxRandom() -> Int {
    return Int(arc4random_uniform(UInt32(self))) + 1
  }
}
