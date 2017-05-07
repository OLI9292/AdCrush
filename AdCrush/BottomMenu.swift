///
/// BottomMenu.swift
///

import SpriteKit
import Then
import UIKit

class BottomMenu: UIView {
  
  enum MenuItemType {
    case investment, industry, medium
    
    static var menuItems: [(type: MenuItemType, image: UIImage)] {
      return [
        (.industry, #imageLiteral(resourceName: "industry")),
        (.medium, #imageLiteral(resourceName: "medium")),
        (.investment, #imageLiteral(resourceName: "investment"))
      ]
    }
  }
}


// MARK: - Layout
extension BottomMenu {
  
  func addTapGestureRecognizer(for view: UIImageView) {
    let tap = UITapGestureRecognizer(target: self, action: #selector(tappedMenuItem))
    view.isUserInteractionEnabled = true
    view.addGestureRecognizer(tap)
  }
  
  func tappedMenuItem(_ sender: UITapGestureRecognizer) {
    guard let tag = sender.view?.tag else { return }
    openMenu(item: MenuItemType.menuItems[tag].type)
  }
  
  func openMenu(item: MenuItemType) {
    print(item)
  }
  
  override func layoutSubviews() {
    backgroundColor = .white
    
    for (index, item) in MenuItemType.menuItems.enumerated() {
  
      _ = UIImageView().then {
        $0.image = item.image
        $0.tag = index
        addSubview($0)
        // Tap Gesture Recognizer
        addTapGestureRecognizer(for: $0)
        // Constraints
        $0.freeConstraints()
        $0.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        let xOffset = CGFloat((index + 1)) * frame.size.width / CGFloat((MenuItemType.menuItems.count + 1))
        $0.centerXAnchor.constraint(equalTo: leadingAnchor, constant: xOffset).isActive = true
        $0.heightAnchor.constraint(equalToConstant: 50).isActive = true
        $0.widthAnchor.constraint(equalToConstant: 50).isActive = true
      }
    }
  }
}
