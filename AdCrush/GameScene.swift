//
//  GameScene.swift
//  AdCrush
//
//  Created by Benjamin Bernstein on 5/2/17.
//  Copyright © 2017 Oliver . All rights reserved.
//

import SpriteKit

class GameScene: SKScene {

    let advertisement = SKSpriteNode(imageNamed: "mcdonalds-1")
    
    override func didMove(to view: SKView) {
        self.backgroundColor = SKColor.white
        advertisement.size = CGSize(width: 200, height: 200)
        //advertisement.zRotation = CGFloat(Double.pi / 4)
        advertisement.position = CGPoint(x: size.width / 2 , y: size.height / 2)
        addChild(advertisement)
    }
    
    
}
