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
      
      _ = UILabel().then {
        $0.text = item.title
        $0.textAlignment = .center
        $0.font = UIFont(name: "VT323-Regular", size: 12)
        $0.backgroundColor = Palette.lightGrey.color
        $0.tag = index
        addSubview($0)
        // Tap Gesture Observer
        observeForTap($0)
        // Constraints
        $0.freeConstraints()
        $0.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        let xOffset = CGFloat((index + 1)) * frame.size.width / CGFloat((MenuItemType.menuItems.count + 1))
        $0.centerXAnchor.constraint(equalTo: leadingAnchor, constant: xOffset).isActive = true
        $0.heightAnchor.constraint(equalToConstant: 30).isActive = true
        $0.widthAnchor.constraint(equalToConstant: 45).isActive = true
      }
    }
  }
  
  private func observeForTap(_ view: UILabel) {
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
