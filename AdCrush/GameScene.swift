///
/// GameScene.swift
///

import RxCocoa
import RxSwift
import RxRealm
import RealmSwift
import SpriteKit
import Then

class GameScene: SKScene {
  
  let bag = DisposeBag()
  private var karmaCounter: KarmaCounter!

  private var noAds: Bool {
    return children.filter({ $0 is Advertisement }).count == 0
  }
  
  private func setup() {
    backgroundColor = Palette.backgroundMain.color
    
    addKarmaCounter()
    addRandomAdvertisement()
  }
  
  private func observe() {
    observeUser()
  }

  // Mark: - Overrides
  
  override func didMove(to view: SKView) {
    setup()
    observe()
  }
  
  override func update(_ currentTime: TimeInterval) {
    if noAds { addRandomAdvertisement() }
  }

  // MARK: - Setup
  
  private func addRandomAdvertisement() {
    let advertisement = Advertisement(skScene: self)
    advertisement.layout()
  }
  
  private func addKarmaCounter() {
    karmaCounter = KarmaCounter(skScene: self)
    karmaCounter.layout()
  }

  // MARK: - Observe
  
  private func observeUser() {
    Observable.from(object: RealmController.user, properties: ["karma"])
      .subscribe(onNext: { user in
        self.karmaCounter.text = "\(user.karma)"
      })
      .addDisposableTo(bag)
  }
}
