///
/// Advertisement.swift
///

import SpriteKit

class Advertisement: SKSpriteNode {
    
  var audioNode: AudioNode!
  
  init(number: Int? = nil) {
    let texture = SKTexture(imageNamed: "ad\(number ?? 4.asMaxRandom())")
    super.init(texture: texture, color: UIColor.blue, size: texture.size())
  }
  
  func crushAdvertisement() {
    audioNode.play()
    
    let crush = Animation.crush.action
    let remove = SKAction.removeFromParent()
    let wait = SKAction.wait(forDuration: 0.5)
    let sequence = SKAction.sequence([crush, wait, remove])
    run(sequence)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - Overrides
extension Advertisement {
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    crushAdvertisement()
  }
}
