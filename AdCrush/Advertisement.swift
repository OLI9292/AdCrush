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
    run(Animation.crush.action, completion: {
      self.removeFromParent()
    })
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
