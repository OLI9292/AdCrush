///
/// Animation.swift
///

import Foundation
import SpriteKit

class Animation {
  var currentIndex = 0
  var warpGrids = [SKWarpGeometry]()
  let length: Float = 0.2
  let iterations: Float = 10
  var times = [NSNumber]()
  
  init() {
    self.times = calculateTimes()
    self.warpGrids = createWarpGrids()
  }
  
  func nextGrid() -> SKWarpGeometry? {
    currentIndex += 1
    guard currentIndex < warpGrids.count else { return nil }
    return warpGrids[currentIndex]
  }
  
  func finishAnimation() -> SKAction {
    var grids = [SKWarpGeometry]()
    var times = [NSNumber]()
    while currentIndex < warpGrids.count {
      print("line 30, current index is \(currentIndex)")
      grids.append(warpGrids[currentIndex])
      times.append(0.1)
      self.currentIndex += 1
    }
    print("gridscount", grids.count)
    print("timescount", times.count)
    return SKAction.animate(withWarps: grids, times: times)!
  }
  
  private func createWarpGrids() -> [SKWarpGeometry] {
    
    func shrink(value: Float) -> Float {
      return value * 0.7
    }
    
    func wiggle(value: Float, dampen: Bool = false) -> Float {
      return value + randomBetween(-0.02, and: 0.02) * (dampen ? value : 1)
    }
    
    func shrinkAndWiggle(value: Float, dampen: Bool = false) -> Float {
      return wiggle(value: shrink(value: value), dampen: dampen)
    }
    
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
    return warpgrids
  }
  
  private func calculateTimes() -> [NSNumber] {
    let times = (0..<Int(iterations)).map({ Float($0) * (length / iterations) }).map { NSNumber(value: $0) }
    return times
  }
}
