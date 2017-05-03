///
/// SpriteKit-Extensions.swift
///

import SpriteKit

extension float2 {
  func map(_ modifier: (Float) -> Float) -> float2 {
    return float2(modifier(x), modifier(y))
  }
}
