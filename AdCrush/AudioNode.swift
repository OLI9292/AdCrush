///
/// AudioNode.swift
///

import Foundation
import SpriteKit

struct AudioNode {
  
  let sound: SKAudioNode
  
  init(soundString: String) {
    self.sound = SKAudioNode(fileNamed: soundString)
    self.sound.run(SKAction.changeVolume(by: 1, duration: 0))
    sound.autoplayLooped = false
  }
  
  func play() {
    sound.run(SKAction.play())
  }
}
