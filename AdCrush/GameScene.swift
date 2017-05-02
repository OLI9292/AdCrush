//
//  GameScene.swift
//  AdCrush
//
//  Created by Benjamin Bernstein on 5/2/17.
//  Copyright © 2017 Oliver . All rights reserved.
//

import SpriteKit

class GameScene: SKScene {

    
    override func didMove(to view: SKView) {
        self.backgroundColor = SKColor.white
        let ad = randomAd()
        ad.position = CGPoint(x: size.width / 2 , y: size.height / 2)
        addChild(ad)
    }
    
    override func update(_ currentTime: TimeInterval) {
        if self.children.count == 0 {
            let ad = randomAd()
            ad.position = CGPoint(x: size.width / 2 , y: size.height / 2)
            self.addChild(ad)
        }
    }
    
    func randomAd() -> Advertisement {
        let randomIndex = Int(arc4random_uniform(4) + 1 )
        return Advertisement(imageNamed: "ad\(randomIndex)")
    }
    
    
}
