///
/// GameScene.swift
///

import RxCocoa
import RxSwift
import SpriteKit
import Then

class GameScene: SKScene {
  
  let bag = DisposeBag()
  var karmaCounter: KarmaCounter!
  
  var noAds: Bool {
    return children.filter({ $0 is Advertisement }).count == 0
  }
  
  func setup() {
    backgroundColor = Palette.backgroundMain.color
    
    addKarmaCounter()
    addRandomAdvertisement()
  }
  
  func observe() {
    observeUser()
  }
}


// Mark: - Overrides
extension GameScene {
  
  override func didMove(to view: SKView) {
    setup()
    observe()
  }
  
  override func update(_ currentTime: TimeInterval) {
    if noAds { addRandomAdvertisement() }
  }
}


// MARK: - Setup
extension GameScene {
  
  func addRandomAdvertisement() {
    let advertisement = Advertisement(skScene: self)
    advertisement.layout()
  }
  
  func addKarmaCounter() {
    karmaCounter = KarmaCounter(skScene: self)
    karmaCounter.layout()
  }
}


// MARK: - Observe
extension GameScene {
  
  func observeUser() {
    GameController.shared.currentUser()
      .observeOn(MainScheduler.instance)
      .subscribe(onNext: { data in
        self.karmaCounter.text = "\(data.karma)"
      })
      .addDisposableTo(bag)
  }
}
