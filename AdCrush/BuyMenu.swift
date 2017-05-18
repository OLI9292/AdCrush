///
/// BuyMenu.swift
///

import Then
import RxSwift
import RxGesture
import RealmSwift
import UIKit

class BuyMenu: UIView, UITableViewDelegate, UITableViewDataSource {
  
  let bag = DisposeBag()
  
  let itemsTableView = UITableView()
  let subtitleLabel = UILabel()
  let closeButton = UIButton()
  
  var menuItemType: MenuItemType
  let items: [ForSaleItem]
  
  init(_ menuItemType: MenuItemType, frame: CGRect) {
    self.menuItemType = menuItemType
    self.items = GameController.shared.forSaleItems(for: menuItemType)
    super.init(frame: frame)
    
  }
  
  override func layoutSubviews() {
  
    backgroundColor = Palette.lightGrey.color
    
    // Title
    let title = UILabel().then {
      addSubview($0)
      $0.text = menuItemType.title.uppercased()
      $0.font = UIFont(name: "VT323-Regular", size: 28)
      // Constraints
      $0.freeConstraints()
      $0.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
      $0.topAnchor.constraint(equalTo: topAnchor, constant: height(percentageOf: 0.05)).isActive = true
    }
    
    // Current Value Subtitle
    _ = subtitleLabel.then {
      addSubview($0)
      $0.font = UIFont(name: "VT323-Regular", size: 14)
      $0.textColor = Palette.darkGrey.color
      // Constraints
      $0.freeConstraints()
      $0.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
      $0.topAnchor.constraint(equalTo: title.bottomAnchor).isActive = true
    }
    
    Observable.from(object: RealmController.user)
      .subscribe(onNext: { user in
        //self.subtitleLabel.text = self.subtitle(for: self.menuItemType)
      })
      .addDisposableTo(bag)
    
    // Items Table View
    _ = itemsTableView.then {
      $0.delegate = self
      $0.dataSource = self
      $0.register(ForSaleItemCell.self, forCellReuseIdentifier: ForSaleItemCell.reuseID)
      $0.backgroundColor = Palette.transparent.color
      $0.separatorColor = Palette.transparent.color
      $0.showsVerticalScrollIndicator = false
      addSubview($0)
      // Constraints
      $0.freeConstraints()
      $0.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
      $0.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
      $0.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 20).isActive = true
      $0.bottomAnchor.constraint(equalTo: bottomAnchor, constant: closeButton.frame.height).isActive = true
    }
    
    // Close Button
    _ = closeButton.then {
      $0.backgroundColor = Palette.darkGrey.color
      let title = NSAttributedString(string: "CLOSE", attributes: [NSFontAttributeName: UIFont(name: "VT323-Regular", size: 28)!])
      $0.setAttributedTitle(title, for: .normal)
      $0.isUserInteractionEnabled = true
      // Tap Gesture Observer
      observeForTap($0)
      addSubview($0)
      // Constraints
      $0.freeConstraints()
      $0.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
      $0.heightAnchor.constraint(equalToConstant: 40).isActive = true
      $0.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
      $0.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
    }
  }
  
  private func observeForTap(_ view: UIButton) {
    view.rx
      .anyGesture(.tap())
      .when(.recognized)
      .subscribe(onNext: { _ in
        self.removeFromSuperview()
      })
      .addDisposableTo(bag)
  }

  
  /*
   private func subtitle(for menuType: MenuItemType) -> String {
   switch menuType {
   case .industry:
   return "CURRENT VALUE PER CRUSH: \(RealmController.user.valuePerCrush.noDecimals)"
   case .medium:
   return "CURRENT MULTIPLIER PER CRUSH: \(RealmController.user.multiplierPerCrush.noDecimals)x"
   case .investment:
   return "CURRENT KARMA PER SECOND: \(RealmController.user.karmaPerSecond.noDecimals)"
   }
   }
   */
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}


// MARK: - Table View Methods
extension BuyMenu {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return items.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: ForSaleItemCell.reuseID, for: indexPath) as! ForSaleItemCell
    cell.selectionStyle = .none
    cell.item = items[indexPath.row]
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 100
  }
}
