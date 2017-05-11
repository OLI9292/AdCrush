///
/// KarmaCounter.swift
///

import RxSwift
import RxRealm
import SpriteKit
import Then

class KarmaCounter: SKSpriteNode, GameElement {
  
  var bag = DisposeBag()
  
  var skScene: SKScene
  let backgroundSize = CGSize(width: 40, height: 40)
  var lastScore: String = "0"
  
  init(skScene: SKScene) {
    self.skScene = skScene
    super.init(texture: nil, color: Palette.transparent.color, size: skScene.size)
    
    lastScore = String(RealmController.user.karma)
    newLabelNodes(score: lastScore)
    observeKarma()
  }
  
  private func observeKarma() {
    Observable.from(object: RealmController.user, properties: ["karma"])
      .subscribe(onNext: { user in
        self.updateScore(user.karma.clean)
      })
      .addDisposableTo(bag)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Layout
  
  func updateScore(_ score: String) {
    let sameLength = score.characters.count == lastScore.characters.count
    sameLength ? updateNodes(score: score) : newLabelNodes(score: score)
    lastScore = score
  }
  
  func updateNodes(score: String) {
    for (index, (new, _)) in zip(score.characters, lastScore.characters).enumerated().filter( { $1.0 != $1.1 }) {
      let label = self.children.flatMap({ $0.childNode(withName: "textLabel-\(index)") }).first as? SKLabelNode
      UIView.animate(withDuration: 0.1, animations: { label?.text = String(new) })
    }
  }
  
  func newLabelNodes(score: String) {
    removeAllChildrenNodes()
    addKarmaIcon()
    addDigitNodes(for: score)
    repositionKarmaCounter(for: score)
  }
  
  func removeAllChildrenNodes() {
    children.forEach { $0.run(SKAction.fadeOut(withDuration: 0.1)) }
    children.forEach { $0.removeFromParent() }
  }
  
  func addKarmaIcon() {
    let background = whiteBackgroundNode(at: 0, size: backgroundSize)
    addChild(background)
    
    let karmaImage = SKSpriteNode(imageNamed: "sun")
    karmaImage.size = CGSize(width: 30, height: 30)
    karmaImage.alpha = 0.7
    karmaImage.position = CGPoint(x: 0, y: 0)
    
    background.addChild(karmaImage)
    background.run(SKAction.fadeIn(withDuration: 0.1))
  }
  
  func addDigitNodes(for score: String) {
    for (index, character) in score.characters.enumerated() {
      let background = whiteBackgroundNode(at: index + 1, size: backgroundSize)
      addChild(background)
      let label = textLabelNode(for: character, atIndex: index)
      background.addChild(label)
      background.run(SKAction.fadeIn(withDuration: 0.1))
    }
  }
  
  func repositionKarmaCounter(for score: String) {
    let numberOfBoxes = CGFloat(score.characters.count + 1)
    let xDisplacement = CGFloat(numberOfBoxes / 2 * backgroundSize.width)
    position = CGPoint(x: skScene.size.width / 2 - xDisplacement,  y: skScene.size.height / 1.2 )
  }
  
  func whiteBackgroundNode(at locationIndex: Int, size: CGSize) -> SKShapeNode {
    return SKShapeNode().then {
      $0.path = UIBezierPath(
        roundedRect: CGRect(
          x: -backgroundSize.width / 2,
          y: -backgroundSize.width / 2,
          width: backgroundSize.width,
          height: backgroundSize.height),
        cornerRadius: 5).cgPath
      $0.fillColor = .white
      $0.position = CGPoint(x: 50 * locationIndex, y: 0)
      $0.alpha = 0
    }
  }
  
  func textLabelNode(for character: Character, atIndex index: Int) -> SKLabelNode {
    return SKLabelNode().then {
      $0.name = "textLabel-\(index)"
      $0.text = String(character)
      $0.verticalAlignmentMode = .center
      $0.fontName = "Baloo-Regular"
      $0.fontColor = Palette.darkGrey.color
      $0.text = String(character)
    }
  }
  
  func layout() {
    skScene.addChild(self)
  }
}
