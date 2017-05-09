///
/// Extensions.swift
///

import Foundation
import UIKit

extension Int {
  func asMaxRandom() -> Int {
    return Int(arc4random_uniform(UInt32(self))) + 1
  }
}

func randomBetween(_ first: Float, and second: Float) -> Float {
  return Float(arc4random()) / Float(UINT32_MAX) * abs(first - second) + min(first, second)
}

extension Float {
  var clean: String {
    return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
  }
}


// MARK: - UIKit
extension UIView {
  func freeConstraints() {
    translatesAutoresizingMaskIntoConstraints = false
  }
  
  func height(percentageOf: CGFloat) -> CGFloat {
    return percentageOf * frame.size.height
  }
  
  func width(percentageOf: CGFloat) -> CGFloat {
    return percentageOf * frame.size.width
  }
}

extension UIViewController {
  
  func height(percentageOf: CGFloat) -> CGFloat {
    return percentageOf * view.frame.size.height
  }
  
  func width(percentageOf: CGFloat) -> CGFloat {
    return percentageOf * view.frame.size.width
  }
}
