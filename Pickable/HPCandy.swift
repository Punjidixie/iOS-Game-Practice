//
//  HPCandy.swift
//  Practice
//
//  Created by Siraphop Rungtragoolchai on 24/9/19.
//  Copyright © 2019 Siraphop Rungtragoolchai. All rights reserved.
//

import Foundation
import SpriteKit

class HPCandy: Pickable{
    
    
    var heal : CGFloat = 10
    var healLabel = SKLabelNode(fontNamed: "Avenir Next Ultra Light")

    
    override init(){
        super.init()
        spriteBody.texture = SKTexture(imageNamed: "Potion")
        zPosition = 1
        
        healLabel.fontColor = SKColor.black
        healLabel.fontSize = 25
        healLabel.position = CGPoint(x: size.width / 2, y: 0)
        healLabel.zPosition = 1
        healLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        healLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        healLabel.text = " + \(Int(heal))"
        addChild(healLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updatePickable(deltaFrameTime: TimeInterval){ //direction of self.zRotation, 1 frame only
        healLabel.text = " + \(Int(heal))"
        
    }

    
    override func hits(something : SKSpriteNode){
        if something is Player{
            let player = something as! Player
            if player.hp < player.maxHp{
                removeFromParent()
            }
        }
    }
    
    override func affectsPlayer(player : Player){
        
        if player.hp < player.maxHp{
            player.hp += heal
        }
        if player.hp > player.maxHp{
            player.hp = player.maxHp
        }
    }
    
    
    
}

