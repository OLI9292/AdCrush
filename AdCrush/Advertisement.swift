//
//  Advertisement.swift
//  AdCrush
//
//  Created by Benjamin Bernstein on 5/2/17.
//  Copyright © 2017 Oliver . All rights reserved.
//

import Foundation
import SpriteKit


class Advertisement: SKSpriteNode {
    
    let crunchSound = SKAudioNode(fileNamed: "crumple.aif")
    
    init(imageNamed: String) {
        let texture = SKTexture(imageNamed: imageNamed)
        super.init(texture: texture, color: UIColor.blue, size: texture.size())
        
        self.isUserInteractionEnabled = true
        self.size = CGSize(width: 200, height: 200)
        
        crunchSound.autoplayLooped = false
        self.addChild(crunchSound)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        crunchSound.run(SKAction.play())
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.size.height = self.size.height / 1.1
        if self.size.height < 30 {
            let finalShrinkAction = SKAction.scaleY(to: 0, duration: 0.4)
            crunchSound.run(SKAction.play())
            self.run(finalShrinkAction, completion: {
                self.crunchSound.removeFromParent()
                self.removeFromParent()
            })
            
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        crunchSound.run(SKAction.stop())
    }
    
}
