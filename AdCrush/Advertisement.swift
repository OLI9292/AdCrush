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
    
    //let crunchSound = SKAudioNode(fileNamed: "crumple.aif")
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //crunchSound.autoplayLooped = false
        //self.addChild(crunchSound)
        //self.run(SKAction.playSoundFileNamed("crumple.aif", waitForCompletion: false))
        // start crunch sound
    
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.size.height = self.size.height / 1.1
        if self.size.height < 10 {
            self.size.height = 10
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // stop sound if it's playing
    }
    
}
