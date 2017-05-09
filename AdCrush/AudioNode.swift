///
/// AudioNode.swift
///

import Foundation
import SpriteKit

struct AudioNode {
  
  let sound: SKAudioNode
  
  init(soundString: String) {
    self.sound = SKAudioNode(fileNamed: soundString)
    self.sound.run(SKAction.changeVolume(by: 10, duration: 0))
    sound.autoplayLooped = false
  }
  
  func play() {
    sound.run(SKAction.play())
  }
}
