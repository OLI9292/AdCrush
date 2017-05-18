///
/// RecruittCounter.swift
///

import RxSwift
import RxRealm
import SpriteKit
import Then

class RecruitCounter: SKLabelNode, GameElement {
  
  var bag = DisposeBag()
  
  var skScene: SKScene
  let backgroundSize = CGSize(width: 40, height: 40)
  
  init(skScene: SKScene) {
    self.skScene = skScene
    super.init()
    setup()
    //  observeRecruitsForLocation(location: Location)
  }
  
//  private func observeRecruitsForLocation(location: Location) {
    // TODO - Observe Recruits for Location
//    Observable.from(object: RealmController.user, properties: ["karmaPerSecond"])
//      .subscribe(onNext: { user in
//        self.updateRecruits(String(user.karmaPerSecond.clean))
//      })
//      .addDisposableTo(bag)
//  }
  
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
//  func updateRecruits(_ recruits: String) {
//    self.text = "\(recruits)"
//  }
  
  // MARK: - Layout
  
  func setup() {
    fontSize = 32
    text = "R3"
    fontName = "VT323-Regular"
    fontColor = Palette.blue.color
    position = CGPoint(x: 50 ,  y: skScene.size.height / 1.1 )
  }
  
  
  func layout() {
    skScene.addChild(self)
  }
}
