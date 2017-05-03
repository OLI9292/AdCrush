///
/// GameScene.swift
///

import SpriteKit
import Then

class GameScene: SKScene {
  
  func addRandomAdvertisementToScene() {
    _ = Advertisement().then {
      $0.position = CGPoint(x: size.width / 2 , y: size.height / 2)
      $0.size = CGSize(width: 200, height: 200)
      $0.isUserInteractionEnabled = true
      addChild($0)
      $0.crushSound = AudioNode(soundString: "crumple.aif").sound
    }
  }
}

// Mark: - Overrides
extension GameScene {
  
  override func sceneDidLoad() {
    backgroundColor = .white
  }
  
  override func didMove(to view: SKView) {
    addRandomAdvertisementToScene()
  }
  
  override func update(_ currentTime: TimeInterval) {
    if children.count == 0 { addRandomAdvertisementToScene() }
  }
}
