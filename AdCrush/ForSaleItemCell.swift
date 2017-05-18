///
/// ForSaleItemCell.swift
///

import RxGesture
import RxSwift
import UIKit

class ForSaleItemCell: UITableViewCell {
  
  let bag = DisposeBag()
  
  let background = UIView()
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
    return [background, itemImageView, nameLabel, valueLabel, priceLabel, isCompleteImageView, currentLevelLabel]
  }
  
  static var reuseID = "forSaleItem"
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    setup()
  }
  
  func setup() {
    guard let item = item else { return }
    
    backgroundColor = Palette.lightGrey.color
    
    // MARK: - Layout
    
    views.forEach { contentView.addSubview($0) }
    views.forEach { $0.freeConstraints() }
    
    _ = background.then {
      $0.backgroundColor = Palette.lighterGrey.color
      // Anchors
      $0.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
      $0.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
      $0.heightAnchor.constraint(equalToConstant: height(percentageOf: 0.8)).isActive = true
      $0.widthAnchor.constraint(equalToConstant: width(percentageOf: 0.9)).isActive = true
    }
    
    /*_ = itemImageView.then {
      $0.image = UIImage(named: item.name.lowercased())
    }*/
    
    _ = currentLevelLabel.then {
      $0.font = UIFont(name: "VT323-Regular", size: 24)
      // Anchors
      $0.widthAnchor.constraint(equalToConstant: 20).isActive = true
      $0.leadingAnchor.constraint(equalTo: background.leadingAnchor, constant: 20).isActive = true
      $0.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    _ = nameLabel.then {
      $0.text = item.name.uppercased()
      $0.textAlignment = .left
      $0.numberOfLines = 2
      $0.font = UIFont(name: "VT323-Regular", size: 24)
      // Anchors
      $0.leadingAnchor.constraint(equalTo: currentLevelLabel.trailingAnchor, constant: 10).isActive = true
      $0.trailingAnchor.constraint(equalTo: valueLabel.leadingAnchor).isActive = true
      $0.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    _ = valueLabel.then {
      $0.font = UIFont(name: "VT323-Regular", size: 14)
      // Anchors
      $0.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -height(percentageOf: 0.1)).isActive = true
      $0.leadingAnchor.constraint(equalTo: trailingAnchor, constant: -width(percentageOf: 0.25)).isActive = true
      
    }
    
    _ = priceLabel.then {
      $0.font = UIFont(name: "VT323-Regular", size: 14)
      // Anchors
      $0.centerYAnchor.constraint(equalTo: centerYAnchor, constant: height(percentageOf: 0.1)).isActive = true
      $0.leadingAnchor.constraint(equalTo: trailingAnchor, constant: -width(percentageOf: 0.25)).isActive = true
      $0.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
    
    _ = isCompleteImageView.then {
      $0.image = #imageLiteral(resourceName: "KARMA-FPO").withRenderingMode(.alwaysTemplate)
      $0.tintColor = Palette.white.color
      $0.isHidden = true
      // Anchors
      $0.centerXAnchor.constraint(equalTo: priceLabel.centerXAnchor).isActive = true
      $0.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
      $0.heightAnchor.constraint(equalToConstant: 40).isActive = true
      $0.widthAnchor.constraint(equalTo: isCompleteImageView.heightAnchor).isActive = true
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
        self.currentLevelLabel.text = item.currentLevelString
        if item.isComplete {
          self.priceLabel.text = ""
          self.valueLabel.text = ""
          self.isCompleteImageView.isHidden = false
        } else {
          self.priceLabel.text = "Cost: \(self.price.clean)"
          self.valueLabel.text = "Value: \(item.itemType.subTitle(for: self.value.clean))"
        }
      })
      .addDisposableTo(bag)
    
    // Observe karma for ability to purchase
    Observable.from(object: RealmController.user, properties: ["karma"])
      .subscribe(onNext: { user in
        self.priceLabel.isUserInteractionEnabled = user.karma > self.price
        self.priceLabel.textColor = user.karma > self.price ? .black : .red
      })
      .addDisposableTo(bag)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
