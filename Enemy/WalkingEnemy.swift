//
//  WalkingEnemy.swift
//  Practice
//
//  Created by Siraphop Rungtragoolchai on 20/9/19.
//  Copyright © 2019 Siraphop Rungtragoolchai. All rights reserved.
//

import Foundation
import SpriteKit

class WalkingEnemy: Enemy{
    
    let sightRange : CGFloat = 800
    var cooldownTime : TimeInterval = TimeInterval(Double.random(in: 0.5...1.5))
    
    override init(){
        super.init()
        enemyBody.texture = SKTexture(imageNamed: "WalkingEnemy")
        
        size = CGSize(width: 150, height: 150)
        enemyBody.size = size
        spriteBody.size = size
        setPhysicsBody(circleOfRadius: size.width / 2)
        
        movementSpeed = 100
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func updateEnemy(deltaFrameTime: TimeInterval){
        super.updateEnemy(deltaFrameTime: deltaFrameTime)
        distanceToMove = movementSpeed * CGFloat(deltaFrameTime)
        cooldownTime -= deltaFrameTime
    }
    
    override func moveEnemy(distance: CGFloat){ //called in didSimulatedPhysics()
        let distanceToTarget = sqrt(pow(position.y - target.position.y, 2) + pow(position.x - target.position.x, 2))
        enemyBody.zRotation = atan2(target.position.y - position.y, target.position.x - position.x)
        
        if distanceToTarget >= sightRange{
            position.x += distance * cos(enemyBody.zRotation)
            position.y += distance * sin(enemyBody.zRotation)
        }
        else if distanceToTarget < sightRange{
            if cooldownTime < 0{
                cooldownTime = 2
                shoot()
            }
        }
    }
    
    override func shoot(){
        let bullet = ChargingBullet()
        bullet.position = position
        bullet.bulletBody.zRotation = enemyBody.zRotation
        bullet.owner = self;
        parent?.addChild(bullet)
    }
    
    
    
}
