///
/// BottomMenu.swift
///

import SpriteKit
import Then
import RxGesture
import RxSwift
import UIKit

class BottomMenu: UIView {
  
  let bag = DisposeBag()
  
  private func observeForTap(_ view: UIImageView) {
    view.rx
      .anyGesture(.tap())
      .when(.recognized)
      .subscribe(onNext: { _ in
        let menuItemType = MenuItemType.menuItems[view.tag].type
        let alreadyOpen = GameController.shared.openMenu.value == menuItemType
        GameController.shared.openMenu.value = alreadyOpen ? nil : menuItemType
      })
      .addDisposableTo(bag)
  }
  
  override func layoutSubviews() {
    backgroundColor = .white
    
    for (index, item) in MenuItemType.menuItems.enumerated() {
      
      _ = UIImageView().then {
        $0.image = item.image
        $0.tag = index
        addSubview($0)
        // Tap Gesture Observer
        observeForTap($0)
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
