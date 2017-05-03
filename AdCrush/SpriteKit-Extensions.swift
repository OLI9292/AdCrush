///
/// SpriteKit-Extensions.swift
///

import SpriteKit
import Then

extension SKSpriteNode {
  
  func addSkew(value: CGFloat = -1) {
    let transform = CGAffineTransform(a: 1, b:  0, c: value, d: 1, tx: 0, ty: 0)
    let transformFilter = CIFilter(name: "CIAffineTransform")!
    transformFilter.setValue(transform, forKey: "inputTransform")
    
    _ = SKEffectNode().then {
      $0.shouldRasterize = true
      $0.shouldEnableEffects = true
      $0.addChild(SKSpriteNode(texture: texture))
      $0.zPosition = 1
      $0.filter = transformFilter
      addChild($0)
    }
    
    texture = nil
  }
}
