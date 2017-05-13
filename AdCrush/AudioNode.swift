///
/// AudioNode.swift
///

import Foundation
import SpriteKit

struct AudioNode {
  
  let sound: SKAudioNode
  var name: String = "audioNode"
  
  init(soundString: String) {
    self.sound = SKAudioNode(fileNamed: soundString)
    self.sound.run(SKAction.changeVolume(by: 1, duration: 0))
    sound.autoplayLooped = false
  }
  
  func play() {
    let play = SKAction.play()
    let wait = SKAction.wait(forDuration: 1)
    let removeFromParent = SKAction.removeFromParent()
    let sequence = SKAction.sequence([play, wait, removeFromParent])
    self.sound.run(sequence)
  }
}
