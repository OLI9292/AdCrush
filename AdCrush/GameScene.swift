//
//  GameScene.swift
//  AdCrush
//
//  Created by Benjamin Bernstein on 5/2/17.
//  Copyright © 2017 Oliver . All rights reserved.
//

import SpriteKit

class GameScene: SKScene {

    let mcdonaldsAd = Advertisement(imageNamed: "mcdonalds")
    
    override func didMove(to view: SKView) {
        self.backgroundColor = SKColor.white
        mcdonaldsAd.name = "mcdonaldsAd"
        mcdonaldsAd.isUserInteractionEnabled = true
        mcdonaldsAd.size = CGSize(width: 200, height: 200)
        mcdonaldsAd.position = CGPoint(x: size.width / 2 , y: size.height / 2)
        addChild(mcdonaldsAd)
    }
    
    
}
