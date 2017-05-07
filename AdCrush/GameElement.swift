///
/// GameElement.swift
///

import Foundation
import SpriteKit
import UIKit

protocol GameElement {
  var skScene: SKScene { get }
  
  mutating func layout()
}
