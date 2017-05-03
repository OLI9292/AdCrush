///
/// Advertisement.swift
///

import SpriteKit

class Advertisement: SKSpriteNode {
  
  var crushed = false
  
  var crushSound: SKAudioNode? {
    didSet {
      if let sound = crushSound { addChild(sound) }
    }
  }
  
  init(number: Int? = nil) {
    let texture = SKTexture(imageNamed: "ad\(number ?? 4.asMaxRandom())")
    super.init(texture: texture, color: UIColor.blue, size: texture.size())
  }
  
  func crushSound(play: Bool) {
    if crushed { return }
    play ? crushSound?.run(SKAction.play()) : crushSound?.run(SKAction.stop())
  }
  
  func crushAdvertisementCompletely() {
    crushed = true
    let crushAction = SKAction.scaleY(to: 0, duration: 0.4)
    run(crushAction, completion: {
      self.crushSound?.removeFromParent()
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
    crushSound(play: true)
  }
  
  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    crushSound(play: true)
    size.height = size.height / 1.1
    if size.height < 30 && !crushed { crushAdvertisementCompletely() }
  }
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    crushSound(play: false)
  }
}
