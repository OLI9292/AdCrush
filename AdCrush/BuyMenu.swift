///
/// BuyMenu.swift
///

import Then
import RxSwift
import RealmSwift
import UIKit

class BuyMenu: UIView, UITableViewDelegate, UITableViewDataSource {
  
  let bag = DisposeBag()
  
  let itemsTableView = UITableView()
  let subtitleLabel = UILabel()
  
  var menuItemType: MenuItemType
  let items: [ForSaleItem]
  
  init(_ menuItemType: MenuItemType, frame: CGRect) {
    self.menuItemType = menuItemType
    self.items = GameController.shared.forSaleItems(for: self.menuItemType)
    super.init(frame: frame)
    
    layout()
  }
  
  
  func layout() {
    backgroundColor = Palette.background(menu: menuItemType).color
    
    // Title
    let title = UILabel().then {
      addSubview($0)
      $0.text = menuItemType.rawValue.uppercased()
      $0.font = UIFont(name: "Baloo-Regular", size: 32)
      $0.textColor = .white
      // Constraints
      $0.freeConstraints()
      $0.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
      $0.topAnchor.constraint(equalTo: topAnchor, constant: height(percentageOf: 0.05)).isActive = true
    }
    
    // Current Value Subtitle
    _ = subtitleLabel.then {
      addSubview($0)
      $0.font = UIFont(name: "Baloo-Regular", size: 14)
      $0.textColor = Palette.darkGrey.color
      // Constraints
      $0.freeConstraints()
      $0.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
      $0.topAnchor.constraint(equalTo: title.bottomAnchor).isActive = true
    }
    
    Observable.from(object: RealmController.user)
      .subscribe(onNext: { user in
        self.subtitleLabel.text = self.subtitle(for: self.menuItemType)
      })
      .addDisposableTo(bag)
    
    // Items Table View
    _ = itemsTableView.then {
      $0.delegate = self
      $0.dataSource = self
      $0.register(ForSaleItemCell.self, forCellReuseIdentifier: ForSaleItemCell.reuseID)
      $0.backgroundColor = Palette.transparent.color
      $0.showsVerticalScrollIndicator = false
      addSubview($0)
      // Constraints
      $0.freeConstraints()
      $0.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
      $0.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
      $0.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 20).isActive = true
      $0.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
  }
  
  private func subtitle(for menuType: MenuItemType) -> String {
    switch menuType {
    case .industry:
      return "CURRENT VALUE PER CRUSH: \(RealmController.user.valuePerCrush.clean)"
    case .investment:
      return "CURRENT KARMA PER SECOND: \(RealmController.user.karmaPerSecond.clean)"
    case .medium:
      return "CURRENT MULTIPLIER PER CRUSH: \(RealmController.user.multiplierPerCrush.clean)x"
    }
  }
  
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
    return 80
  }
}
