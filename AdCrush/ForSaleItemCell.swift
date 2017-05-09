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
  let isCompleteImageView = UIImageView()
  let currentLevelLabel = UILabel()
  
  var item: ForSaleItem? {
    didSet {
      setup()
    }
  }
  
  var price: Float {
    return item?.nextLevel?.price ?? 0
  }
  
  var value: Float {
    return item?.nextLevel?.value ?? 0
  }
  
  var views: [UIView] {
    return [itemImageView, nameLabel, valueLabel, priceLabel, isCompleteImageView, currentLevelLabel]
  }
  
  static var reuseID = "forSaleItem"
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    setup()
  }
  
  func setup() {
    guard let item = item else { return }
    
    // MARK: - Layout
    
    backgroundColor = Palette.transparent.color
    
    views.forEach { contentView.addSubview($0) }
    views.forEach { $0.freeConstraints() }
    
    _ = itemImageView.then {
      $0.image = UIImage(named: item.name.lowercased())
      // Anchors
      $0.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
      $0.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5).isActive = true
      $0.widthAnchor.constraint(equalTo: itemImageView.heightAnchor).isActive = true
      $0.leadingAnchor.constraint(equalTo: leadingAnchor, constant: width(percentageOf: 0.1)).isActive = true
    }
    
    _ = nameLabel.then {
      $0.text = item.name
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
      // Anchors
      $0.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
      $0.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -width(percentageOf: 0.1)).isActive = true
    }
    
    _ = isCompleteImageView.then {
      $0.image = #imageLiteral(resourceName: "sun")
      $0.isHidden = true
      // Anchors
      $0.centerXAnchor.constraint(equalTo: priceLabel.centerXAnchor).isActive = true
      $0.centerYAnchor.constraint(equalTo: priceLabel.centerYAnchor).isActive = true
      $0.heightAnchor.constraint(equalToConstant: 50).isActive = true
      $0.widthAnchor.constraint(equalTo: isCompleteImageView.heightAnchor).isActive = true
    }
    
    _ = currentLevelLabel.then {
      $0.font = UIFont(name: "Baloo-Regular", size: 20)
      // Anchors
      $0.centerXAnchor.constraint(equalTo: itemImageView.leadingAnchor).isActive = true
      $0.centerYAnchor.constraint(equalTo: itemImageView.bottomAnchor).isActive = true
    }
    
    // MARK: - Observe
    
    // Observe purchase button
    priceLabel.rx
      .anyGesture(.tap())
      .when(.recognized)
      .subscribe(onNext: { _ in
        RealmController.user.buy(item: item)
      })
      .addDisposableTo(bag)
    
    // Observe item level for price and level text
    Observable.collection(from: item.levels)
      .subscribe(onNext: { _ in
        self.currentLevelLabel.text = item.currentLevelText
        if item.isComplete {
          self.priceLabel.text = ""
          self.valueLabel.text = ""
          self.isCompleteImageView.isHidden = false
        } else {
          self.priceLabel.text = self.price.clean
          self.valueLabel.text = item.itemType.subtitle(self.value.clean)
        }
      })
      .addDisposableTo(bag)
    
    // Observe karma for ability to purchase
    Observable.from(object: RealmController.user, properties: ["karma"])
      .subscribe(onNext: { user in
        self.priceLabel.isUserInteractionEnabled = user.karma > self.price
        self.priceLabel.textColor = user.karma > self.price ? .white : Palette.darkGrey.color
      })
      .addDisposableTo(bag)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
