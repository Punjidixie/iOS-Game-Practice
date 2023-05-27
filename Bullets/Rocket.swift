//
//  Rocket.swift
//  Practice
//
//  Created by Siraphop Rungtragoolchai on 28/9/19.
//  Copyright © 2019 Siraphop Rungtragoolchai. All rights reserved.
//

import Foundation
import SpriteKit

class Rocket: Bullet{
    
    override init(){
        super.init()
        bulletBody.texture = SKTexture(imageNamed: "DarkgreyCircleArrow")
        size = CGSize(width: 50, height: 50)
        bulletBody.size = size
        
        movementSpeed = CGFloat(400)
        maxDistance = CGFloat(750)
        
        damage = 25
        
        setPhysicsBody(circleOfRadius: size.width / 2)
    }
    
    override func updateBullet(deltaFrameTime: TimeInterval) {
        super.updateBullet(deltaFrameTime: deltaFrameTime)
    }
    
    override func moveBullet(distance: CGFloat) {
        position.x += distance * cos(bulletBody.zRotation)
        position.y += distance * sin(bulletBody.zRotation)
        
        currentTravelDistance += distance
        
        if currentTravelDistance > maxDistance{
            spawnFlamePool()
            die()
        }
    }
    
    override func hits(something: SKSpriteNode) {
        if something is Wall || something is Enemy{
            spawnFlamePool()
            die()
        }
    }
    
    override func affectsEnemy(enemy: Enemy) {
        enemy.hp -= damage
    }
    
    func spawnFlamePool(){
        let flamePool = FlamePool()
        flamePool.position = position
        flamePool.owner = owner
        parent?.addChild(flamePool)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

