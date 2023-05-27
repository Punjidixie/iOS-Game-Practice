//
//  UnpredictableEnemy.swift
//  Practice
//
//  Created by Siraphop Rungtragoolchai on 29/9/19.
//  Copyright © 2019 Siraphop Rungtragoolchai. All rights reserved.
//

import Foundation
import SpriteKit

class UnpredictableEnemy: Enemy{
    var cooldownTime : TimeInterval = TimeInterval(Double.random(in: 0.5...1.5))
    
    override init(){
        super.init()
        enemyBody.texture = SKTexture(imageNamed: "Blank")
        spriteBody.texture = SKTexture(imageNamed: "UnpredictableEnemy")
        
        size = CGSize(width: 150, height: 150)
        
        enemyBody.size = size
        setPhysicsBody(circleOfRadius: size.width / 2)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func updateEnemy(deltaFrameTime: TimeInterval){
        enemyBody.zRotation = atan2(target.position.y - position.y, target.position.x - position.x)
        cooldownTime -= deltaFrameTime
        if cooldownTime < 0{
            cooldownTime = TimeInterval(CGFloat.random(in: 0.5...3.5))
            shoot()
        }
        super.updateEnemy(deltaFrameTime: deltaFrameTime)
    }
    
    override func moveEnemy(distance: CGFloat){ //called in didSimulatedPhysics()
        
    }
    
    override func shoot(){
        let bullet = QueBullet()
        bullet.position = position
        bullet.bulletBody.zRotation = enemyBody.zRotation
        bullet.owner = self;
        parent?.addChild(bullet)
    }
    
}

