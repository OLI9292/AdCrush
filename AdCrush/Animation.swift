///
/// Animation.swift
///

import Foundation
import SpriteKit

enum Animation {
  case crushLeft, crushRight, crushUp, crushDown
  
  var action: SKAction {
    switch self {
    case .crushLeft:
      return crushLeft
    case .crushRight:
      return crushRight
    case .crushUp:
      return crushUp
    case .crushDown:
      return crushDown
    }
    
  }
}

enum CrushDirection: String {
  case left, right, up, down
}

private typealias CrushAction = Animation
extension CrushAction {
  
  func shrink(value: Float) -> Float {
    return value * 0.9
  }
  
  func wiggle(value: Float, dampen: Bool = false) -> Float {
    return value + randomBetween(-0.02, and: 0.02) * (dampen ? value : 1)
  }
  
  func shrinkAndWiggle(value: Float, dampen: Bool = false) -> Float {
    return wiggle(value: shrink(value: value), dampen: dampen)
  }
  
  var crushLeft: SKAction {
    let length: Float = 0.2
    let iterations: Float = 20
    let times: [NSNumber] = (0..<Int(iterations)).map({ Float($0) * (length / iterations) }).map { NSNumber(value: $0) }
    
    var source = [
      float2(0, 0), float2(0.25, 0), float2(0.5, 0), float2(0.75, 0), float2(1, 0),
      float2(0, 0.25), float2(0.25, 0.25), float2(0.5, 0.25), float2(0.75, 0.25), float2(1, 0.25),
      float2(0, 0.5), float2(0.25, 0.5), float2(0.5, 0.5), float2(0.75, 0.5), float2(1, 0.5),
      float2(0, 0.75), float2(0.25, 0.75), float2(0.5, 0.75), float2(0.75, 0.75), float2(1, 0.75),
      float2(0, 1), float2(0.25, 1), float2(0.5, 1), float2(0.75, 1), float2(1, 1)
    ]

    func leftVectorShift(_ vector: float2) -> float2 {
      return float2( shrinkAndWiggle(value: vector.x, dampen: false), wiggle(value: vector.y))
    }
    
    let warpgrids: [SKWarpGeometry] = times.reduce([]) { (geometries, _) in
      let destination = source.map(leftVectorShift)
      let geometry = SKWarpGeometryGrid(columns: 4, rows: 4, sourcePositions: source, destinationPositions: destination)
      source = destination
      return geometries + [geometry]
    }
    
    return SKAction.animate(withWarps: warpgrids, times: times)!
  }

  
  var crushRight: SKAction {
    print("crush it right")
    return SKAction()
  }
  
  var crushUp: SKAction {
    print("crush it up")
    return SKAction()
  }
  
  var crushDown: SKAction {
    
    let length: Float = 0.2
    let iterations: Float = 20
    let times: [NSNumber] = (0..<Int(iterations)).map({ Float($0) * (length / iterations) }).map { NSNumber(value: $0) }
    
    var source = [
      float2(0, 0), float2(0.25, 0), float2(0.5, 0), float2(0.75, 0), float2(1, 0),
      float2(0, 0.25), float2(0.25, 0.25), float2(0.5, 0.25), float2(0.75, 0.25), float2(1, 0.25),
      float2(0, 0.5), float2(0.25, 0.5), float2(0.5, 0.5), float2(0.75, 0.5), float2(1, 0.5),
      float2(0, 0.75), float2(0.25, 0.75), float2(0.5, 0.75), float2(0.75, 0.75), float2(1, 0.75),
      float2(0, 1), float2(0.25, 1), float2(0.5, 1), float2(0.75, 1), float2(1, 1)
    ]
    
    func shiftVector(_ vector: float2) -> float2 {
      return float2(wiggle(value: vector.x), shrinkAndWiggle(value: vector.y, dampen: false))
    }
    
    let warpgrids: [SKWarpGeometry] = times.reduce([]) { (geometries, _) in
      let destination = source.map(shiftVector)
      let geometry = SKWarpGeometryGrid(columns: 4, rows: 4, sourcePositions: source, destinationPositions: destination)
      source = destination
      return geometries + [geometry]
    }
    
    return SKAction.animate(withWarps: warpgrids, times: times)!
  }
}
