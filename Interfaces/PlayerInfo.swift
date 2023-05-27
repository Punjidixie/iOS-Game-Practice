//
//  PlayerInfo.swift
//  Practice
//
//  Created by Siraphop Rungtragoolchai on 14/9/19.
//  Copyright © 2019 Siraphop Rungtragoolchai. All rights reserved.
//

import Foundation
import SpriteKit

class PlayerInfo: SKSpriteNode, SKPhysicsContactDelegate{
    
    var gameContentNode : GameContentNode!
    var target : Player!
    var positionLabel = SKLabelNode(fontNamed: "Avenir Light")
    var hpLabel = SKLabelNode(fontNamed: "Avenir Light")
    var energyLabel = SKLabelNode(fontNamed: "Avenir Light")
    
    init(){
        
        let texture = SKTexture(imageNamed: "Blank")
        super.init(texture: texture, color: UIColor(), size: CGSize(width: 0, height: 0))
        
        positionLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        hpLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        energyLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        
        positionLabel.fontSize = 50
        positionLabel.fontColor = SKColor.black
        positionLabel.position = CGPoint(x: 0, y: 150)
        positionLabel.zPosition = 1
        addChild(positionLabel)
        
        hpLabel.fontSize = 50
        hpLabel.fontColor = SKColor.black
        hpLabel.position = CGPoint(x: 0, y: 75)
        hpLabel.zPosition = 1
        addChild(hpLabel)
        
        energyLabel.fontSize = 50
        energyLabel.fontColor = SKColor.black
        energyLabel.position = CGPoint(x: 0, y: 0)
        energyLabel.zPosition = 1
        addChild(energyLabel)
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(){
        target = gameContentNode.player
        positionLabel.text = "Position: \(Int(target.position.x)) , \(Int(target.position.y)), \(Int(target.playerBody.zRotation * (180 / .pi)))"
        hpLabel.text = "HP: \(Int(target.hp))"
        energyLabel.text = "Energy: \(Int(target.energy))"
    }
    
    
}
