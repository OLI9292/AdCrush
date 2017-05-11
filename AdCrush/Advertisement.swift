///
/// Advertisement.swift
///

import SpriteKit
import RxSwift
import RxGesture

class Advertisement: SKSpriteNode, GameElement {
  
  var bag = DisposeBag()
  
  var audioNode: AudioNode!
  var skScene: SKScene
  
  init(skScene: SKScene) {
    self.skScene = skScene
    let texture = SKTexture(imageNamed: "ad\(10.asMaxRandom())")
    
    super.init(texture: texture, color: UIColor.blue, size: texture.size())
    observeGesture()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Observer
  
  func observeGesture() {
    skScene.view?.rx
      .panGesture()
      .skip(1)
      .take(1)
      .subscribe(onNext: { gesture in
        // Measured in points / sec
        let velocity: CGPoint = gesture.velocity(in: self.skScene.view)
        let direction = self.determineDirection(velocity: velocity)
        self.crush(with: velocity, direction: direction)
      })
      .addDisposableTo(bag)
  }
  
  private func determineDirection(velocity: CGPoint) -> CrushDirection {
    let isVerticalGesture = abs(velocity.y) > abs(velocity.x)
    if isVerticalGesture {
      return velocity.y < 0 ? CrushDirection.up : CrushDirection.down
    } else {
      return velocity.x > 0 ? CrushDirection.right : CrushDirection.left
    }
    
  }
  // MARK: - Animation
  
  func crush(with velocity: CGPoint, direction: CrushDirection) {
    RealmController.user.gain(karma: RealmController.user.totalKarmaPerCrush)
    
    // audioNode?.play()
 
    let crush = crushAction(with: direction)
    let wait = SKAction.wait(forDuration: 0.3)
    let remove = SKAction.removeFromParent()
    let sequence = SKAction.sequence([crush, wait, remove])
    run(sequence)
  }
  
  private func crushAction(with direction: CrushDirection) -> SKAction {
    var typeOfCrush: Animation!
    switch direction {
    case .left:
      typeOfCrush = .crushLeft
    case .right:
      typeOfCrush = .crushRight
    case .down:
      typeOfCrush = .crushDown
    case .up:
      typeOfCrush = .crushUp
    }
    return typeOfCrush.action
  }
  
  // MARK: - Layout
  
  func layout() {
    position = CGPoint(x: skScene.size.width / 2 , y: skScene.size.height / 2)
    size = CGSize(width: 300, height: 300)
    isUserInteractionEnabled = true
    skScene.addChild(self)
    audioNode = AudioNode(soundString: "stomp.wav")
    skScene.addChild(self.audioNode!.sound)
  }
  
}
