///
/// ForSaleItemCell.swift
///

import RxGesture
import RxSwift
import UIKit

class ForSaleItemCell: UITableViewCell {
  
  let bag = DisposeBag()
  
  let itemImageView = UIImageView()
  let nameLabel = UILabel()
  let valueLabel = UILabel()
  let priceLabel = UILabel()

  var item: ForSaleItem! {
    didSet {
      nameLabel.text = item.name
      itemImageView.image = UIImage(named: item.name.lowercased())
      valueLabel.text = String(describing: item.nextLevel?.price ?? 0)
      priceLabel.text = String(describing: item.nextLevel?.value)
    }
  }
  
  var views: [UIView] {
    return [itemImageView, nameLabel, valueLabel, priceLabel]
  }
  
  static var reuseID = "forSaleItem"
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    layout()
  }
  
  // MARK: - Layout
  
  func layout() {
    backgroundColor = Palette.transparent.color
    
    views.forEach { contentView.addSubview($0) }
    views.forEach { $0.freeConstraints() }
    
    _ = itemImageView.then {
      // Anchors
      $0.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
      $0.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5).isActive = true
      $0.widthAnchor.constraint(equalTo: itemImageView.heightAnchor).isActive = true
      $0.leadingAnchor.constraint(equalTo: leadingAnchor, constant: width(percentageOf: 0.1)).isActive = true
    }
    
    _ = nameLabel.then {
      $0.font = UIFont(name: "Baloo-Regular", size: 20)
      // Anchors
      $0.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: 20).isActive = true
      $0.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
    }
    
    _ = valueLabel.then {
      $0.font = UIFont(name: "Baloo-Regular", size: 12)
      // Anchors
      $0.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor).isActive = true
      $0.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
    }
    
    _ = priceLabel.then {
      $0.font = UIFont(name: "Baloo-Regular", size: 24)
      // Tap Gesture Observer
      observeForTap($0)
      // Anchors
      $0.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
      $0.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -width(percentageOf: 0.1)).isActive = true
    }
  }
  
  // MARK: - User Interaction
  
  private func observeForTap(_ view: UILabel) {
    view.rx
      .anyGesture(.tap())
      .when(.recognized)
      .subscribe(onNext: { _ in
        GameController.shared.buy(self.item)
      })
      .addDisposableTo(bag)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
