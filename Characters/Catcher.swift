//
//  Catcher.swift
//  Practice
//
//  Created by Siraphop Rungtragoolchai on 24/6/19.
//  Copyright © 2019 Siraphop Rungtragoolchai. All rights reserved.
//

import Foundation
import SpriteKit

class Catcher: Player{
    
    override init(){
        super.init()
        playerBody.texture = SKTexture(imageNamed: "Blank")
        spriteBody.texture = SKTexture(imageNamed: "Catcher")
        
        size = CGSize(width: 150, height: 150)
        playerBody.size = size
        spriteBody.size = size
        setPhysicsBody(circleOfRadius: size.width / 2)
        
        setPlayerPhantoms(circleOfRadius: size.width / 2)
        
        aimLine.size = CGSize(width: 800, height: 75)
        
        initMaxHp(maxHp : 200)
        initMaxEnergy(maxEnergy : 50)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func shoot(){
        if energy >= 15 && attackCooldown <= 0{
            energy -= 15
            let thiccBullet = Boomerang()
            thiccBullet.position = position
            thiccBullet.bulletBody.zRotation = playerBody.zRotation
            thiccBullet.owner = self;
            parent?.addChild(thiccBullet)
            
            spriteCooldown = 0.25
            attackCooldown = 0.25
        }
    }
    
    override func aimedShoot(angle: CGFloat) {
        if energy >= 15 && attackCooldown <= 0{
            energy -= 15
            
            
            let thiccBullet = Boomerang()
            thiccBullet.position = position
            thiccBullet.bulletBody.zRotation = angle
            thiccBullet.owner = self;
            parent?.addChild(thiccBullet)
            
            spriteBody.zRotation = angle
            spriteCooldown = 0.25
            attackCooldown = 0.25
        }
    }
    
}
