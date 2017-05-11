//
//  CrushAnimation.swift
//  AdCrush
//
//  Created by Benjamin Bernstein on 5/11/17.
//  Copyright © 2017 Oliver The Big Dog. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class CrushAnimation {
  let velocity: CGPoint
  var absoluteVelocity: Float!
  let direction: CrushDirection
  var length: Float = 0.0
  
  let iterations: Float = 20
  
  var source = [float2]()
  var action = SKAction()
  
  init(velocity: CGPoint, direction: CrushDirection) {
    self.velocity = velocity
    self.direction = direction
    
    self.absoluteVelocity = calculateAbsoluteVelocity(velocity: velocity)

    // This could use some improving
    self.length =  {
      let speed = 100 / self.absoluteVelocity
      guard speed <= 0.4 else { return 0.4 }
      guard speed >= 0.1 else { return 0.1 }
      return speed }()
    
     calculateAction(direction: direction)
  }
  
  func calculateAbsoluteVelocity(velocity: CGPoint) -> Float {
    if direction == .left || direction == .right { return abs(Float(velocity.x)) }
    else { return abs(Float(velocity.y)) }
  }
  
  func calculateAction(direction: CrushDirection) {
    setupSourceGrid()
    
    let times: [NSNumber] = (0..<Int(iterations)).map({ Float($0) * (length / iterations) }).map { NSNumber(value: $0) }
    
    let vectorShift = determineVectorShift()
    
    let warpgrids: [SKWarpGeometry] = times.reduce([]) { (geometries, _) in
      let destination = source.map(vectorShift)
      let geometry = SKWarpGeometryGrid(columns: 4, rows: 4, sourcePositions: source, destinationPositions: destination)
      source = destination
      return geometries + [geometry]
    }
    
    action = SKAction.animate(withWarps: warpgrids, times: times)!
  }
  
  private func determineVectorShift() -> (float2) -> float2 {
    
    // works
    func shiftDown(_ vector: float2) -> float2 {
      return float2(wiggle(value: vector.x), shrinkAndWiggle(value: vector.y, dampen: false))
    }
    
    // doesn't work yet
    func shiftUp(_ vector: float2) -> float2 {
      return float2(wiggle(value: vector.x), shrinkAndWiggle(value: vector.y, dampen: false))
    }
    
    // doesn't work yet
    func shiftRight(_ vector: float2) -> float2 {
      return float2(shrinkAndWiggle(value: vector.x, dampen: false), wiggle(value: vector.y))
    }
    
    // works
    func shiftLeft(_ vector: float2) -> float2 {
      return float2(shrinkAndWiggle(value: vector.x, dampen: false), wiggle(value: vector.y))
    }
    
    var vectorShift: (float2) -> float2
    switch direction {
    case .left:
      vectorShift = shiftLeft(_:)
    case .right:
      vectorShift = shiftRight(_:)
    case .up:
      vectorShift = shiftUp(_:)
    case .down:
      vectorShift = shiftDown(_:)
    }
    
    return vectorShift
    
  }
  
  private func setupSourceGrid() {
    source = [
      float2(0, 0), float2(0.25, 0), float2(0.5, 0), float2(0.75, 0), float2(1, 0),
      float2(0, 0.25), float2(0.25, 0.25), float2(0.5, 0.25), float2(0.75, 0.25), float2(1, 0.25),
      float2(0, 0.5), float2(0.25, 0.5), float2(0.5, 0.5), float2(0.75, 0.5), float2(1, 0.5),
      float2(0, 0.75), float2(0.25, 0.75), float2(0.5, 0.75), float2(0.75, 0.75), float2(1, 0.75),
      float2(0, 1), float2(0.25, 1), float2(0.5, 1), float2(0.75, 1), float2(1, 1)
    ]
  }
  
  private func shrink(value: Float) -> Float {
    return value * 0.9
  }
  
  private func wiggle(value: Float, dampen: Bool = false) -> Float {
    return value + randomBetween(-0.02, and: 0.02) * (dampen ? value : 1)
  }
  
  private func shrinkAndWiggle(value: Float, dampen: Bool = false) -> Float {
    return wiggle(value: shrink(value: value), dampen: dampen)
  }
  
}

enum CrushDirection: String {
  case left, right, up, down
}


