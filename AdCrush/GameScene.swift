///
/// GameScene.swift
///

import SpriteKit
import Then

class GameScene: SKScene {
    
    var score: Int = UserDefaults.standard.integer(forKey: "playerScore") {
        didSet {
            updateScoreCounter()
        }
    }
    
    var scoreCounter = SKLabelNode()
    
    func addRandomAdvertisementToScene() {
        
        _ = Advertisement().then {
            $0.position = CGPoint(x: size.width / 2 , y: size.height / 2)
            $0.size = CGSize(width: 300, height: 300)
            $0.isUserInteractionEnabled = true
            $0.alpha = 0
            insertChild($0, at: 0)
            let fadeIn = SKAction.fadeIn(withDuration: 0.2)
            $0.run(fadeIn)
            $0.audioNode = AudioNode(soundString: "stomp.wav")
            $0.addChild($0.audioNode!.sound)
        }
    }
    
    func addScoreCounter() {
        scoreCounter = SKLabelNode().then {
            $0.position = CGPoint(x: size.width / 2 , y: size.height / 1.2 )
            $0.fontSize = 50
            $0.fontColor = SKColor.black
            $0.text = "$\(score)0"
            self.addChild($0)
        }
    }
    
    func updateScoreCounter() {
        let userdefaults = UserDefaults.standard
        userdefaults.set(score, forKey: "playerScore")
        scoreCounter.text = "$\(score)0"
    }
}

// Mark: - Overrides
extension GameScene {
    
    override func sceneDidLoad() {
        backgroundColor = .white
    
    }
    
    override func didMove(to view: SKView) {
        addScoreCounter()
        addRandomAdvertisementToScene()
        addRandomAdvertisementToScene()
        addRandomAdvertisementToScene()

    }
    
    override func update(_ currentTime: TimeInterval) {
        if children.count == 3 {
            score += 1
            addRandomAdvertisementToScene()
        }
    }
}
