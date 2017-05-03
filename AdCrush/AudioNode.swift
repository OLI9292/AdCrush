///
/// AudioNode.swift
///

import Foundation
import SpriteKit

struct AudioNode {
  
  let sound: SKAudioNode
  
  init(soundString: String) {
    self.sound = SKAudioNode(fileNamed: soundString)
    sound.autoplayLooped = false
  }
}
