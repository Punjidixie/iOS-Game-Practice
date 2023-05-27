//
//  SpinningEnemy.swift
//  Practice
//
//  Created by Siraphop Rungtragoolchai on 20/9/19.
//  Copyright © 2019 Siraphop Rungtragoolchai. All rights reserved.
//

import Foundation
import SpriteKit

class SpinningEnemy: Enemy{
    var angularVelocity : CGFloat = 60 * (.pi/180)
    var cooldownTime : TimeInterval = TimeInterval(Double.random(in: 0.5...1.5))
    
    override init(){
        super.init()
        enemyBody.texture = SKTexture(imageNamed: "Lampy")
        
        enemyBody.zRotation = CGFloat(Int.random(in: 0...360)) * (.pi/360)
        
        size = CGSize(width: 150, height: 150)
        enemyBody.size = size
        spriteBody.size = size
        setPhysicsBody(circleOfRadius: size.width / 2)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func updateEnemy(deltaFrameTime: TimeInterval){
        super.updateEnemy(deltaFrameTime: deltaFrameTime)
        enemyBody.zRotation += angularVelocity * CGFloat(deltaFrameTime)
        
        cooldownTime -= deltaFrameTime
        if cooldownTime < 0{
            cooldownTime = 2
            shoot()
        }
    }
    
    override func moveEnemy(distance: CGFloat){ //called in didSimulatedPhysics()
        
    }
    
    override func shoot(){
        for i in 0...3{
            let bullet = SpinningEnemyBullet()
            bullet.position = position
            bullet.bulletBody.zRotation = enemyBody.zRotation + 90 * (.pi/180) * CGFloat(i)
            bullet.owner = self;
            parent?.addChild(bullet)
        }
    }
    
}

