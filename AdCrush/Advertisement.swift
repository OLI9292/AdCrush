///
/// Advertisement.swift
///

import SpriteKit

class Advertisement: SKSpriteNode {
    
    var isBeingCrushed = false
    var audioNode: AudioNode!
    
    init(number: Int? = nil) {
        let texture = SKTexture(imageNamed: "ad\(number ?? 5.asMaxRandom())")
        super.init(texture: texture, color: UIColor.blue, size: texture.size())
    }
    
    func crushAdvertisement() {
        isBeingCrushed = true
        audioNode.play()
        
        let crush = Animation.crush.action
        let wait = SKAction.wait(forDuration: 0.3)
        let remove = SKAction.removeFromParent()
        let sequence = SKAction.sequence([crush, wait, remove])
        run(sequence)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Overrides
extension Advertisement {
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !isBeingCrushed { crushAdvertisement() }
    }
    
    
}
