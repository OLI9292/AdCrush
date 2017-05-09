///
/// AdCrushVC.swift
///

import UIKit
import RxSwift
import SpriteKit

class AdCrushVC: UIViewController {
  
  var gameScene: GameScene!
  var bottomMenu: BottomMenu!
  var spriteKitView: SKView!
  
  let bag = DisposeBag()
  
  enum SubviewType {
    case bottomMenu, buyMenu
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // RealmController.seed()
    
    setup()
    observe()
  }
  
  private func setup() {
    addGameScene()
    addBottomMenu()
  }
  
  private func observe() {
    observeMenu()
  }
  
  // MARK: - Setup

  fileprivate func addGameScene() {
    spriteKitView = view as! SKView
    spriteKitView.ignoresSiblingOrder = false
    
    gameScene = GameScene(size: spriteKitView.bounds.size)
    gameScene.scaleMode = .resizeFill
    
    spriteKitView.presentScene(gameScene)
  }
  
  fileprivate func addBottomMenu() {
    let frame = subviewFrame(SubviewType.bottomMenu)
    bottomMenu = BottomMenu(frame: frame)
    bottomMenu.backgroundColor = .white
    view.addSubview(bottomMenu)
  }
  
  // MARK: - Observe
  
  private func observeMenu() {
    GameController.shared.openMenu.asObservable()
      .subscribe(onNext: { menuItemType in
        if let menuItemType = menuItemType {
          self.open(menuItemType)
        } else {
          self.closeMenu()
        }
      })
      .addDisposableTo(bag)
  }
  
  // MARK: - Animations
  
  private func open(_ menuItemType: MenuItemType) {
    closeMenu()
    let frame = subviewFrame(SubviewType.buyMenu)
    let buyMenu = BuyMenu(menuItemType, frame: frame)
    view.insertSubview(buyMenu, belowSubview: bottomMenu)
    UIView.animate(withDuration: 1, animations: {
      buyMenu.frame.origin.y -= self.height(percentageOf: 0.7)
    }, completion: nil)
  }
  
  private func closeMenu() {
    view.subviews.filter({ $0 is BuyMenu }).first?.removeFromSuperview()
  }
  
  // MARK: - SubView Frames
  
  private func subviewFrame(_ subviewType: SubviewType) -> CGRect {
    switch subviewType {
    case .bottomMenu:
      return CGRect(
        x: view.frame.origin.x,
        y: view.frame.size.height - height(percentageOf: 0.1),
        width: view.frame.size.width,
        height: height(percentageOf: 0.1))
    case .buyMenu:
      return CGRect(
        x: view.frame.origin.x,
        y: view.frame.size.height - height(percentageOf: 0.1),
        width: view.frame.size.width,
        height: height(percentageOf: 0.7))
    }
  }
}
