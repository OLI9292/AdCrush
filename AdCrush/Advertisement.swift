///
/// Advertisement.swift
///

import SpriteKit

class Advertisement: SKSpriteNode, GameElement {
  
  var isBeingCrushed = false
  var audioNode: AudioNode!
  var skScene: SKScene
  
  init(skScene: SKScene) {
    self.skScene = skScene
    let texture = SKTexture(imageNamed: "ad\(8.asMaxRandom())")
    
    super.init(texture: texture, color: UIColor.blue, size: texture.size())
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - Animation {
extension Advertisement {
  
  func crush() {
    isBeingCrushed = true
    // audioNode?.play()
    
    let crush = Animation.crush.action
    let wait = SKAction.wait(forDuration: 0.3)
    let remove = SKAction.removeFromParent()
    let sequence = SKAction.sequence([crush, wait, remove])
    run(sequence)
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
  
  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    if !isBeingCrushed { crush() }
  }
}
