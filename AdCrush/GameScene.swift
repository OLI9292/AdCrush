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
  
  // Mark: - Overrides
  
  override func didMove(to view: SKView) {
    setup()
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
}
