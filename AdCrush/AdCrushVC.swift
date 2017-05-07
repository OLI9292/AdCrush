///
/// AdCrushVC.swift
///

import UIKit
import SpriteKit

class AdCrushVC: UIViewController {
  
  var gameScene: GameScene!
  var spriteKitView: SKView!
  
  enum SubviewType {
    case bottomMenu
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setup()
  }
  
  func setup() {
    addGameScene()
    addBottomMenu(frame: frame(for: SubviewType.bottomMenu))
  }
}


// MARK: - Setup
extension AdCrushVC {

  func addGameScene() {
    spriteKitView = view as! SKView
    spriteKitView.ignoresSiblingOrder = false
    
    gameScene = GameScene(size: spriteKitView.bounds.size)
    gameScene.scaleMode = .resizeFill
    
    spriteKitView.presentScene(gameScene)
  }
  
  func addBottomMenu(frame: CGRect) {
    let bottomMenu = BottomMenu(frame: frame)
    view.addSubview(bottomMenu)
    bottomMenu.layout()
  }
  
  func frame(for subviewType: SubviewType) -> CGRect {
    switch subviewType {
    case .bottomMenu:
      return CGRect(
        x: view.frame.origin.x,
        y: view.frame.size.height - 100,
        width: view.frame.size.width,
        height: 100)
    }
  }
}
