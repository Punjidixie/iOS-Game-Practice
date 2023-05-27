//
//  RocketLauncher.swift
//  Practice
//
//  Created by Siraphop Rungtragoolchai on 28/9/19.
//  Copyright © 2019 Siraphop Rungtragoolchai. All rights reserved.
//

import Foundation
import SpriteKit

class RocketLauncher: Player{
    
    let bulletSpread : CGFloat = 30 * (.pi/180)
    
    override init(){
        super.init()
        playerBody.texture = SKTexture(imageNamed: "Blank")
        spriteBody.texture = SKTexture(imageNamed: "Scallion of Peace HD")
        
        size = CGSize(width: 150, height: 150)
        playerBody.size = size
        spriteBody.size = size
        
        setPhysicsBody(circleOfRadius: size.width / 2)
        setPlayerPhantoms(circleOfRadius: size.width / 2)
        
        aimLine.size = CGSize(width: 750, height: 80)
        
        initMaxHp(maxHp : 150)
        initMaxEnergy(maxEnergy : 50)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func updatePlayer(deltaFrameTime: TimeInterval) {
        super.updatePlayer(deltaFrameTime: deltaFrameTime)
    }
    override func shoot(){
        if energy >= 25 && attackCooldown <= 0{
            energy -= 25
            
            let rocket = Rocket()
            rocket.bulletBody.zRotation = zRotation
            rocket.owner = self
            rocket.position = position
            parent?.addChild(rocket)
            
            
            spriteBody.zRotation = playerBody.zRotation
            spriteCooldown = 0.5
            attackCooldown = 0.5
        }
    }
    
    override func aimedShoot(angle : CGFloat){
        if energy >= 25 && attackCooldown <= 0{
            energy -= 25
            
            let rocket = Rocket()
            rocket.bulletBody.zRotation = angle
            rocket.owner = self
            rocket.position = position
            parent?.addChild(rocket)
            
            spriteBody.zRotation = angle
            spriteCooldown = 0.5
            attackCooldown = 0.5
        }
    }
    
}

