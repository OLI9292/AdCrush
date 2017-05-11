///
/// KPSCounter.swift
///

import RxSwift
import RxRealm
import SpriteKit
import Then

class KPSCounter: SKLabelNode, GameElement {
  
  var bag = DisposeBag()
  
  var skScene: SKScene
  let backgroundSize = CGSize(width: 40, height: 40)
  
  init(skScene: SKScene) {
    self.skScene = skScene
    super.init()
    setup()
    observeKarmaPerSecond()
  }
  
  private func observeKarmaPerSecond() {
    Observable.from(object: RealmController.user, properties: ["karmaPerSecond"])
      .subscribe(onNext: { user in
        self.updateKPS(String(user.karmaPerSecond.clean))
      })
      .addDisposableTo(bag)
  }
  
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func updateKPS(_ karmaPerSecond: String) {
    self.text = "\(karmaPerSecond) Karma Per Second"
  }
  
  // MARK: - Layout
  
  func setup() {
    fontSize = 18
    fontName = "Baloo-Regular"
    fontColor = Palette.white.color
    position = CGPoint(x: skScene.size.width / 2,  y: skScene.size.height / 1.2 )
  }
  
  
  func layout() {
    skScene.addChild(self)
  }
}
