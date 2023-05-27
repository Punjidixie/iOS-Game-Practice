//
//  Boomerang.swift
//  Practice
//
//  Created by Siraphop Rungtragoolchai on 24/6/19.
//  Copyright © 2019 Siraphop Rungtragoolchai. All rights reserved.
//

import Foundation
import SpriteKit

class Boomerang: Bullet{
    
    let maxMovementSpeed = CGFloat(1500)
    let minMovementSpeed = CGFloat(300)
    var returningMovementSpeed = CGFloat(0)
    
    let spriteBodyAngularVelocity = CGFloat(720) * (.pi/180)
    var hitArray : [SKSpriteNode] = []
    
    var goingForward = true
    
    override init(){
        super.init()
        bulletBody.texture = SKTexture(imageNamed: "Blank")
        spriteBody.texture = SKTexture(imageNamed: "Boomerang")
        
        size = CGSize(width: 75, height: 75)
        bulletBody.size = size
        spriteBody.size = size
        
        movementSpeed = CGFloat(1500)
        maxDistance = CGFloat(800)
        
        damage = 30
        
        setPhysicsBody(circleOfRadius: size.width/2)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func updateBullet(deltaFrameTime: TimeInterval){
        distanceToMove = movementSpeed * CGFloat(deltaFrameTime)
        spriteBody.zRotation += CGFloat(deltaFrameTime) * spriteBodyAngularVelocity
    }
    
    override func moveBullet(distance: CGFloat){
        
        if currentTravelDistance > maxDistance{ //returning back to the owner
            
            if goingForward{
                goingForward = false
                
                returningMovementSpeed = movementSpeed
                
                if returningMovementSpeed < minMovementSpeed{
                    returningMovementSpeed = minMovementSpeed
                }
                hitArray = []
            }
            
            if physicsBody!.allContactedBodies().contains(owner.physicsBody!){
                removeFromParent()
            }
            else if owner.parent == nil{
                removeFromParent()
            }

            movementSpeed = returningMovementSpeed + (currentTravelDistance - maxDistance) * 1.5
            bulletBody.zRotation = atan2(owner.position.y - position.y, owner.position.x - position.x)
            
        }
        else{ //going forward
            movementSpeed = maxMovementSpeed - (currentTravelDistance * 1.5);
        }
        
        position.x += distance * cos(bulletBody.zRotation)
        position.y += distance * sin(bulletBody.zRotation)
        currentTravelDistance += distance
    }
    
    
    override func hits(something : SKSpriteNode){
        if something is Wall{
            if currentTravelDistance < maxDistance{
                currentTravelDistance = maxDistance
                returningMovementSpeed = movementSpeed
                hitArray = []
            }
        }
    }
    
    override func affectsEnemy(enemy: Enemy) {
        if !hitArray.contains(enemy){
            enemy.deductsHp(hpDeduct: damage)
            hitArray.append(enemy)
        }
    }
}
