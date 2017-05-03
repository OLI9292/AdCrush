///
/// AdCrushVC.swift
///

import UIKit
import SpriteKit

class AdCrushVC: UIViewController {
  
  var gameScene: GameScene!
  var spriteKitView: SKView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }
}

// MARK: - Setup
extension AdCrushVC {
  
  func setup() {
    spriteKitView = view as! SKView
    spriteKitView.ignoresSiblingOrder = false
    
    gameScene = GameScene(size: spriteKitView.bounds.size)
    gameScene.scaleMode = .resizeFill
    
    spriteKitView.presentScene(gameScene)
  }
}
