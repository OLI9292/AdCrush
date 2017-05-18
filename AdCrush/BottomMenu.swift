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
  
  override func layoutSubviews() {
    backgroundColor = .white
    
    for (index, item) in MenuItemType.menuItems.enumerated() {
      
      _ = UIButton().then {
        $0.setImage(item.image.withRenderingMode(.alwaysTemplate), for: .normal)
        $0.tintColor = Palette.darkGrey.color
        $0.tag = index
        addSubview($0)
        // Tap Gesture Observer
        observeForTap($0)
        // Constraints
        $0.freeConstraints()
        $0.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        let xOffset = CGFloat((index + 1)) * frame.size.width / CGFloat((MenuItemType.menuItems.count + 1))
        $0.centerXAnchor.constraint(equalTo: leadingAnchor, constant: xOffset).isActive = true
        let imageEdgeInset: CGFloat = 8.0
        $0.imageEdgeInsets.left = imageEdgeInset
        $0.imageEdgeInsets.right = imageEdgeInset
        $0.imageEdgeInsets.top = imageEdgeInset
        $0.imageEdgeInsets.bottom = imageEdgeInset
        $0.heightAnchor.constraint(equalToConstant: 50).isActive = true
        $0.widthAnchor.constraint(equalToConstant: 50).isActive = true
      }
    }
  }
  

  private func observeForTap(_ view: UIButton) {
    view.rx
      .anyGesture(.tap())
      .when(.recognized)
      .subscribe(onNext: { _ in
        let menuItemType: MenuItemType = MenuItemType.menuItems[view.tag]
        switch menuItemType {
        case .invest, .recruits, .gear:
          GameController.shared.openMenu.value = menuItemType
        case .map:
          // push map
          break
        case .karmaPool:
          // push karmaPool
          break
        }
      })
      .addDisposableTo(bag)
  }
}
