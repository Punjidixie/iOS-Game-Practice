//
//  Lampy.swift
//  Practice
//
//  Created by Siraphop Rungtragoolchai on 24/6/19.
//  Copyright © 2019 Siraphop Rungtragoolchai. All rights reserved.
//

import Foundation
import SpriteKit

class Lampy: Player{
    
    override init(){
        super.init()
        playerBody.texture = SKTexture(imageNamed: "Lampy")
        spriteBody.texture = SKTexture(imageNamed: "Blank")
        
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
    override func updatePlayer(deltaFrameTime: TimeInterval) {
        super.updatePlayer(deltaFrameTime: deltaFrameTime)
    }
    override func shoot(){
        if energy >= 10{
            energy -= 10
            run(SKAction.playSoundFileNamed("LampyHarp", waitForCompletion: false))
            let thiccBullet = Thicc()
            thiccBullet.position = position
            thiccBullet.bulletBody.zRotation = playerBody.zRotation
            thiccBullet.owner = self;
            parent?.addChild(thiccBullet)
        }
    }
    
    override func aimedShoot(angle : CGFloat){
        if energy >= 10{
            spriteBody.zRotation = angle
            energy -= 10
            run(SKAction.playSoundFileNamed("LampyHarp", waitForCompletion: false))
            let thiccBullet = Thicc()
            thiccBullet.position = position
            thiccBullet.bulletBody.zRotation = spriteBody.zRotation
            thiccBullet.owner = self;
            parent?.addChild(thiccBullet)
        }
    }
    
}
