///
/// Advertisement.swift
///

import SpriteKit

class Advertisement: SKSpriteNode, GameElement {
  
  var isBeingCrushed = false
  var audioNode: AudioNode!
  var skScene: SKScene
  var lowestY: CGFloat
  var animation = Animation()
  
  init(skScene: SKScene) {
    self.skScene = skScene
    self.lowestY = skScene.frame.height
    let texture = SKTexture(imageNamed: "ad\(8.asMaxRandom())")
    
    super.init(texture: texture, color: UIColor.blue, size: texture.size())
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - Animation {
extension Advertisement {
  
  func nextFrame() {
    if let nextGrid = animation.nextGrid() {
      let warp = SKAction.warp(to: nextGrid, duration: 0.01)
      self.run(warp!)
    } else {
      let wait = SKAction.wait(forDuration: 0.3)
      let remove = SKAction.removeFromParent()
      let fadeOut = SKAction.fadeOut(withDuration: 0.2)
      let sequence = SKAction.sequence([wait, fadeOut, remove])
      self.run(sequence)
    }
  }
}

// MARK: - Layout
extension Advertisement {
  
  func layout() {
    position = CGPoint(x: skScene.size.width / 2 , y: skScene.size.height / 2)
    size = CGSize(width: 300, height: 300)
    isUserInteractionEnabled = true
    skScene.addChild(self)
    audioNode = AudioNode(soundString: "stomp.wav")
    skScene.addChild(self.audioNode!.sound)
  }
}

// MARK: - Overrides
extension Advertisement {
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    lowestY = (touches.first?.location(in: self).y)!
  }
  
  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    guard let touchLocation = touches.first?.location(in: self) else { return }
    let y = touchLocation.y
    print("y is", y)
    if y < lowestY {
      nextFrame()
      lowestY = y - self.frame.height / 20
    }
    
  }
}
