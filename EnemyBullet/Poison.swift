//
//  Poison.swift
//  Practice
//
//  Created by Siraphop Rungtragoolchai on 20/9/19.
//  Copyright © 2019 Siraphop Rungtragoolchai. All rights reserved.
//

import Foundation
import SpriteKit

class Poison: EnemyBullet{
    
    var cooldownTime : TimeInterval = 0
    var thisFrameCanHit = false
    
    override init(){
        super.init()
        bulletBody.texture = SKTexture(imageNamed: "DarkgreyCircleArrow")
        damage = 10 //per 0.5 sec ---> 20 damage / sec
        
        size = CGSize(width: 500, height: 500)
        zPosition = 1
        
        bulletBody.size = size
        movementSpeed = CGFloat(900)
        
        setPhysicsBody(circleOfRadius: size.width / 2)
    }
    
    override func updateBullet(deltaFrameTime: TimeInterval){ //direction of self.zRotation, 1 frame only
        if thisFrameCanHit{
            thisFrameCanHit = false
        }
        
        cooldownTime -= deltaFrameTime
        if cooldownTime < 0{
            cooldownTime = 0
            thisFrameCanHit = true
        }
        
    }
    
    override func moveBullet(distance: CGFloat){
        bulletBody.zRotation = owner.zRotation
        position = owner.position
    }
    
    override func hits(something : SKSpriteNode){
        
    }
    
    override func affectsPlayer(player : Player){
        if thisFrameCanHit{
            player.deductsHp(hpDeduct: damage)
            cooldownTime = 0.5
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
