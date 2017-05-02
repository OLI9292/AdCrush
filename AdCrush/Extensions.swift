//
//  Extensions.swift
//  AdCrush
//
//  Created by Benjamin Bernstein on 5/2/17.
//  Copyright © 2017 Oliver . All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

extension SKSpriteNode {
    
    func addSkew(value: CGFloat = -1){
        
        var effectNode = SKEffectNode()
        effectNode.shouldRasterize = true
        effectNode.shouldEnableEffects = true
        effectNode.addChild(SKSpriteNode(texture: texture))
        effectNode.zPosition = 1
        let transform = CGAffineTransform(a:  1    , b:  0,
                                               c:  value , d:  1,
                                               tx: 0    , ty: 0)
        let transformFilter = CIFilter(name: "CIAffineTransform")!
        transformFilter.setValue(transform, forKey: "inputTransform")
        effectNode.filter = transformFilter
        addChild(effectNode)
        texture = nil
        
    }
    
}
