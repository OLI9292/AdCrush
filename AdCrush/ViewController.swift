///
/// ViewController.swift
///

import UIKit
import SpriteKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scene = GameScene(size: view.bounds.size)
        let skView = self.view as! SKView
        
        skView.ignoresSiblingOrder = true
        scene.scaleMode = .resizeFill
        skView.presentScene(scene)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(crushAd))
        tapGesture.delegate = self
             
    }
    
    func animateCrush() {
        print("animated crush")
    }
    
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func crushAd(_:UITapGestureRecognizer) {
        //replaceVideoWithImage()
        animateCrush()
    }
    
}

