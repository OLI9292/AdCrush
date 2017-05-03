///
/// Animation.swift
///

import Foundation
import SpriteKit

enum Animation {
  case crush
  
  var action: SKAction {
    switch self {
    case .crush:
      return crush
    }
  }
}

private typealias CrushAction = Animation
extension CrushAction {
  
  var crush: SKAction {
    
    let length: Float = 1.5
    let iterations: Float = 10
    let times: [NSNumber] = (0..<Int(iterations)).map({ Float($0) * (length / iterations) }).map { NSNumber(value: $0) }
    
    var source = [
      float2(0, 0), float2(0.5, 0), float2(1, 0),
      float2(0, 0.5), float2(0.5, 0.5), float2(1, 0.5),
      float2(0, 1), float2(0.5, 1), float2(1, 1)
    ]
    
    func shrinkVector(_ vector: float2) -> float2 {
      return vector.map(shrinkValue)
    }
    
    func shrinkValue(_ value: Float) -> Float {
      if value == 0.5 { return 0.5 }
      let change = randomBetween(0.5 / iterations * 0.75, and: 0.5 / iterations)
      return value + (value < 0.5 ? change : -change)
    }
    
    let warpgrids: [SKWarpGeometry] = times.reduce([]) { (geometries, _) in
      let destination = source.map(shrinkVector)
      let geometry = SKWarpGeometryGrid(columns: 2, rows: 2, sourcePositions: source, destinationPositions: destination)
      source = destination
      return geometries + [geometry]
    }

    return SKAction.animate(withWarps: warpgrids, times: times)!
  }
}
