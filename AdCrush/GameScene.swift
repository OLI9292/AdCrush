///
/// GameScene.swift
///

import SpriteKit
import Then

class GameScene: SKScene {
    
    var score = 0 {
        didSet {
            print("set score")
            changeScoreCounter()
        }
    }
    
    var scoreCounter = SKLabelNode()
    
    func addRandomAdvertisementToScene() {
        _ = Advertisement().then {
            $0.position = CGPoint(x: size.width / 2 , y: size.height / 2)
            $0.size = CGSize(width: 300, height: 300)
            $0.isUserInteractionEnabled = true
            addChild($0)
            $0.alpha = 0
            //let randomSoundIndex = Int(arc4random_uniform(3) + 1)
            let fadeIn = SKAction.fadeIn(withDuration: 0.2)
            $0.run(fadeIn)
            $0.audioNode = AudioNode(soundString: "thud\(1).wav")
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
    
    func changeScoreCounter() {
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
    }
    
    override func update(_ currentTime: TimeInterval) {
        if children.count == 1 {
            score += 1
            addRandomAdvertisementToScene() }
    }
}
