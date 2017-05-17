///
/// GameScene.swift
///

import SpriteKit

class GameScene: SKScene {
  
  private var karmaCounter: KarmaCounter!
  private var kpsCounter: KPSCounter!

  private var noAds: Bool {
    return children
      .flatMap { $0 as? Advertisement }
      .filter { !$0.isBeingCrushed }
      .count == 0
  }
  
  private func setup() {
    backgroundColor = .white
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
    Advertisement(skScene: self).layout()
  }
  
  private func addKarmaCounter() {
    KarmaCounter(skScene: self).layout()
  }
  
  private func addKarmaPerSecondCounter() {
    KPSCounter(skScene: self).layout()
  }
}
