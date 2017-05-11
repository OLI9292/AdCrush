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
  private var kpsCounter: KPSCounter!

  private var noAds: Bool {
    return children.filter({ $0 is Advertisement }).count == 0
  }
  
  private func setup() {
    backgroundColor = Palette.backgroundMain.color
    
    addKarmaCounter()
    addKarmaPerSecondCounter()
    addRandomAdvertisement()
  }
  
  // Mark: - Overrides
  
  override func didMove(to view: SKView) {
    setup()
  }
  
  override func update(_ currentTime: TimeInterval) {
    gainKarmaPerFrame()
    if noAds { addRandomAdvertisement()}
  }
  
  // MARK: - Game State Methods
  
  func gainKarmaPerFrame() {
    RealmController.gain(karma: Float(RealmController.user.karmaPerFrame))
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
  
  private func addKarmaPerSecondCounter() {
    kpsCounter = KPSCounter(skScene: self)
    kpsCounter.layout()
  }
}
