//
//  Blade.swift
//  Practice
//
//  Created by Siraphop Rungtragoolchai on 8/9/19.
//  Copyright © 2019 Siraphop Rungtragoolchai. All rights reserved.
//

import Foundation
import SpriteKit

class Blade: Bullet{
    
    let damageIncreaseRate : CGFloat = 30
    
    override init(){
        super.init()
        bulletBody.texture = SKTexture(imageNamed: "DarkgreyCircleArrow")
        
        size = CGSize(width: 50, height: 50)
        bulletBody.size = size
        movementSpeed = CGFloat(1250)
        maxDistance = 1000
        
        damage = 10
        
        setPhysicsBody(circleOfRadius: size.width / 2)
  
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateBullet(deltaFrameTime: TimeInterval){
        distanceToMove = movementSpeed * CGFloat(deltaFrameTime)
        let addedDiameter = CGFloat(125 * (currentTravelDistance / maxDistance))
        size = CGSize(width: 50 + addedDiameter, height: 50 + addedDiameter)
        bulletBody.size = size
        setPhysicsBody(circleOfRadius: size.width / 2)
        
        damage += damageIncreaseRate * CGFloat(deltaFrameTime)
    }
    
    override func hits(something: SKSpriteNode) {
        if something is Wall || something is Enemy{
            die()
        }
    }
    
    override func moveBullet(distance: CGFloat) {
        if currentTravelDistance > maxDistance{
            removeFromParent()
        }
        
        position.x += distance * cos(bulletBody.zRotation)
        position.y += distance * sin(bulletBody.zRotation)
        currentTravelDistance += distance
    }
    
    
    
    
}
