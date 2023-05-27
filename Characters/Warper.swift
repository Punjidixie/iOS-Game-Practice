//
//  Warper.swift
//  Practice
//
//  Created by Siraphop Rungtragoolchai on 9/9/19.
//  Copyright © 2019 Siraphop Rungtragoolchai. All rights reserved.
//

import Foundation
import SpriteKit

class Warper: Player{
    
    override init(){
        super.init()
        playerBody.texture = SKTexture(imageNamed: "Warper")
        
        size = CGSize(width: 150, height: 150)
        playerBody.size = size
        spriteBody.size = size
        setPhysicsBody(circleOfRadius: size.width / 2)
        
        setPlayerPhantoms(circleOfRadius: size.width / 2)
        
        aimLine.size = CGSize(width: 500, height: 75)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func shoot(){
        if energy >= 10{
            energy -= 10
            let pearl = Pearl()
            pearl.position = position
            pearl.bulletBody.zRotation = playerBody.zRotation
            pearl.owner = self;
            parent?.addChild(pearl)
        }
    }
    
    override func aimedShoot(angle : CGFloat){
        if energy >= 10{
            energy -= 10
            spriteBody.zRotation = angle
            let pearl = Pearl()
            pearl.position = position
            pearl.bulletBody.zRotation = spriteBody.zRotation
            pearl.owner = self;
            parent?.addChild(pearl)
        }
    }
    
    
}
