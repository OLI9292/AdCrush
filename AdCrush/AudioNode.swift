///
/// AudioNode.swift
///

import Foundation
import SpriteKit

struct AudioNode {
  
  let sound: SKAudioNode
  
  init(sound: SKAudioNode) {
    self.sound = sound
    sound.autoplayLooped = false
  }
}
