///
/// Advertisement.swift
///

import SpriteKit

class Advertisement: SKSpriteNode, GameElement {
  
  var audioNode: AudioNode!
  var skScene: SKScene
  
  //animation variables
  var isAnimating = false
  var animationTriggerDistances: [CGFloat] = [150, 100, 100]
  var lastY: CGFloat = 150
  var currentTrigger = 0
  var animation = Animation()
  
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
  
  func nextFrame() {
    guard animation.currentIndex + 1 != animation.warpGrids.count else { removeAd(); return }
    if let nextGrid = animation.nextGrid() {
      let warp = SKAction.warp(to: nextGrid, duration: 0.01)
      self.run(warp!)
    }
  }
  
  func finishAnimation() {
    let remainingWarps = animation.finishAnimation()
    self.run(remainingWarps)
    self.removeAd()
  }
  
  func removeAd() {
    let wait = SKAction.wait(forDuration: 0.2)
    let remove = SKAction.removeFromParent()
    let fadeOut = SKAction.fadeOut(withDuration: 0.1)
    let sequence = SKAction.sequence([wait, fadeOut, remove])
    self.run(sequence)
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
    guard let touchLocation = touches.first?.location(in: self) else { return }
    let y = touchLocation.y
    if currentTrigger == animationTriggerDistances.count - 1 && !isAnimating{
      print("trigger finishanimatino")
      isAnimating = true
      finishAnimation()
    }
    if lastY - y >= animationTriggerDistances[currentTrigger] && !isAnimating {
      nextFrame()
      print("y is", y)
      lastY = y
      print("last y is", lastY)
      currentTrigger += 1
    }}
  
}
