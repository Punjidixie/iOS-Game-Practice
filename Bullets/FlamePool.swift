//
//  FlamePool.swift
//  Practice
//
//  Created by Siraphop Rungtragoolchai on 28/9/19.
//  Copyright © 2019 Siraphop Rungtragoolchai. All rights reserved.
//

import Foundation
import SpriteKit

class FlamePool: Bullet{
    
    let lifetime : TimeInterval = 4
    var timePassed : TimeInterval = 0
    let radius : CGFloat = 200
    var hitCooldown : TimeInterval = 0
    var thisFrameCanHit = false
    
    override init(){
        super.init()
        bulletBody.texture = SKTexture(imageNamed: "DarkgreyCircleArrow")
        size = CGSize(width: radius * 2, height: radius * 2)
        bulletBody.size = size
        
        movementSpeed = CGFloat(900)
        maxDistance = CGFloat(1000)
        zPosition = 0
        damage = 7
        
        setPhysicsBody(circleOfRadius: size.width / 2)
    }
    override func updateBullet(deltaFrameTime: TimeInterval) {
        timePassed += deltaFrameTime
        
        if timePassed > lifetime{
            removeFromParent()
        }
        
        if thisFrameCanHit{
            thisFrameCanHit = false
        }
        
        hitCooldown -= deltaFrameTime
        if hitCooldown <= 0{
            thisFrameCanHit = true
            hitCooldown = 1
        }
    }
    
    override func moveBullet(distance: CGFloat) {
        //does not move
    }
    
    override func hits(something: SKSpriteNode) {
       
    }
    
    override func affectsEnemy(enemy: Enemy) {
        if thisFrameCanHit{
            enemy.hp -= damage
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

