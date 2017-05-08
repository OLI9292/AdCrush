///
/// KarmaCounter.swift
///

import SpriteKit

class KarmaCounter: SKSpriteNode, GameElement {
    
    var skScene: SKScene
    var lastScore: String
    let backgroundSize = CGSize(width: 40, height: 40)
    var score: String {
        willSet { lastScore = score }
        didSet { updateScore(score: score) }
    }
    
    init(skScene: SKScene) {
        self.score = "0"
        self.lastScore = "0"
        self.skScene = skScene
        super.init(texture: nil, color: Palette.transparent.color, size: skScene.size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Layout
extension KarmaCounter {
    
    func updateScore(score: String) {
        lastScore.characters.count == score.characters.count ? updateExistingNodes(score: score) : createNewLabelNodes(score: score)
    }
    
    func updateExistingNodes(score: String) {
        for (index, character) in score.characters.enumerated() {
            let index = lastScore.index(lastScore.startIndex, offsetBy: index)
            if lastScore.characters[index] != character {
                let labelToUpdate = self.childNode(withName: "textLabel-\(index)") as! SKLabelNode
                UIView.animate(withDuration: 0.2, animations: {
                    labelToUpdate.text = String(character)
                })
            }
        }
    }
    
    func createNewLabelNodes(score: String) {
        removeAllChildrenNodes()
        addKarmaIcon()
        addDigitNodes(for: score)
        repositionKarmaCounter()
    }
    
    func removeAllChildrenNodes() {
        self.children.forEach {
            $0.run(SKAction.fadeOut(withDuration: 0.2))
            $0.removeFromParent()
        }
        
    }
    
    func addKarmaIcon() {
        let background = whiteBackgroundNode(at: 0, size: backgroundSize)
        self.addChild(background)
        
        let karmaImage = SKSpriteNode(imageNamed: "sun")
        karmaImage.size = CGSize(width: 30, height: 30)
        karmaImage.alpha = 0.7
        karmaImage.position = CGPoint(x: 0, y: 0)
        
        background.addChild(karmaImage)
        background.run(SKAction.fadeIn(withDuration: 0.2))
    }
    
    func addDigitNodes(for score: String) {
        for (index, character) in score.characters.enumerated() {
            
            let background = whiteBackgroundNode(at: index + 1, size: backgroundSize)
            self.addChild(background)
            
            let label = textLabelNode(for: character)
            background.addChild(label)
            
            background.run(SKAction.fadeIn(withDuration: 0.2))
        }
        
    }
    
    func repositionKarmaCounter() {
        let numberOfBoxes = CGFloat(score.characters.count + 1)
        let xDisplacement = CGFloat(numberOfBoxes / 2 * backgroundSize.width)
        self.position = CGPoint(x: skScene.size.width / 2 - xDisplacement,  y: skScene.size.height / 1.2 )
    }
    
    func whiteBackgroundNode(at locationIndex: Int, size: CGSize) -> SKShapeNode {
        let background = SKShapeNode()
        background.path = UIBezierPath(roundedRect: CGRect(x: -backgroundSize.width / 2, y: -backgroundSize.width / 2, width: backgroundSize.width, height: backgroundSize.height), cornerRadius: 5).cgPath
        background.fillColor = .white
        background.position = CGPoint(x: 50 * locationIndex, y: 0)
        background.alpha = 0
        return background
    }
    
    func textLabelNode(for character: Character) -> SKLabelNode {
        let textLabel = SKLabelNode()
        textLabel.name = "textLabel-\(index)"
        textLabel.text = String(character)
        textLabel.verticalAlignmentMode = .center
        textLabel.fontName = "Baloo-Regular"
        textLabel.fontColor = Palette.darkGrey.color
        textLabel.text = String(character)
        return textLabel
    }
    
    func layout() {
        skScene.addChild(self)
    }
}
