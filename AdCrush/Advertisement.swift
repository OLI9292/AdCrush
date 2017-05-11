///
/// Advertisement.swift
///

import SpriteKit
import RxSwift
import RxGesture

class Advertisement: SKSpriteNode, GameElement {
  
  var bag = DisposeBag()
  var isBeingCrushed = false
  
  var audioNode: AudioNode!
  var skScene: SKScene
  
  init(skScene: SKScene) {
    self.skScene = skScene
    
    let texture = SKTexture(imageNamed: "ad\(10.asMaxRandom())")
    
    super.init(texture: texture, color: UIColor.blue, size: texture.size())
    
    addPhysics()
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
  
  // MARK: - Physics
  
  func addPhysics() {
    self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.size.width,
                                                         height: self.size.height))
    physicsBody?.affectedByGravity = false
    physicsBody?.density = 0.7
    physicsBody?.collisionBitMask = 0
    
  }
  
  // MARK: - Animation
  
  func crush(with velocity: CGPoint, direction: CrushDirection) {
    
    RealmController.user.gain(karma: RealmController.user.totalKarmaPerCrush)
   
    isBeingCrushed = true
    physicsBody?.affectedByGravity = true
  
    let flyAway = SKAction.applyImpulse(CGVector(dx: velocity.x * 10, dy: velocity.y * 10), duration: 0.2)
    self.run(flyAway)
    
    //audioNode?.play()
    
    let crush = CrushAnimation(velocity: velocity, direction: direction)
    let crushAction = crush.action
    let wait = SKAction.wait(forDuration: 1.0)
    let remove = SKAction.removeFromParent()
    let sequence = SKAction.sequence([crushAction, wait, remove])
    run(sequence)
  }
  
  private func determineDirection(velocity: CGPoint) -> CrushDirection {
    let isVerticalGesture = abs(velocity.y) > abs(velocity.x)
    if isVerticalGesture {
      return velocity.y < 0 ? CrushDirection.up : CrushDirection.down
    } else {
      return velocity.x > 0 ? CrushDirection.right : CrushDirection.left
    }
    
  }
  
  // MARK: - Overrides
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    let scale = SKAction.scale(by: 1.1, duration: 0.1)
    self.run(scale)
  }
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    let scale = SKAction.scale(by: 0.9, duration: 0.1)
    self.run(scale)
  }
  
  // MARK: - Layout
  
  func layout() {
    position = CGPoint(x: skScene.size.width / 2 , y: skScene.size.height / 2)
    size = CGSize(width: 300, height: 300)
    isUserInteractionEnabled = true
    skScene.insertChild(self, at: 0)
    audioNode = AudioNode(soundString: "stomp.wav")
    skScene.addChild(self.audioNode!.sound)
  }
  
}
