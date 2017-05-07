///
/// KarmaCounter.swift
///

import SpriteKit

class KarmaCounter: SKLabelNode, GameElement {
  
  var skScene: SKScene
  
  init(skScene: SKScene) {
    self.skScene = skScene
    super.init()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}


// MARK: - Layout
extension KarmaCounter {
  
  func layout() {
    position = CGPoint(x: skScene.size.width / 2 , y: skScene.size.height / 1.2 )
    fontSize = 50
    fontColor = SKColor.black
    skScene.addChild(self)
  }
}
