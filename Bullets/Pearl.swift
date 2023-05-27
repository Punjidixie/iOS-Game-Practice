//
//  Pearl.swift
//  Practice
//
//  Created by Siraphop Rungtragoolchai on 9/9/19.
//  Copyright © 2019 Siraphop Rungtragoolchai. All rights reserved.
//

import Foundation
import SpriteKit

class Pearl: Bullet{
    
    var playerPhantomX = PlayerPhantom()
    var playerPhantomY = PlayerPhantom()
    
    var isDeadEnd = false
    var ownerWarpPosition = CGPoint(x: 0,y: 0)
    var hit = false
    
    override init(){
        super.init()
        bulletBody.texture = SKTexture(imageNamed: "Warp")
        size = CGSize(width: 75, height: 75)
        
        bulletBody.size = size
        movementSpeed = CGFloat(1300)
        maxDistance = CGFloat(500)
        
        damage = 30
        setPhysicsBody(rectangleOf: size)
        
        playerPhantomX.size = size //playerPhantom setup
        addChild(playerPhantomX)
        playerPhantomX.position = CGPoint(x: 0, y: 0)
        playerPhantomX.zPosition = 0
        
        playerPhantomY.size = size
        addChild(playerPhantomY)
        playerPhantomY.position = CGPoint(x: 0, y: 0)
        playerPhantomY.zPosition = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateBullet(deltaFrameTime: TimeInterval){
        
        distanceToMove = movementSpeed * CGFloat(deltaFrameTime)
        xToMove = distanceToMove * cos(bulletBody.zRotation)
        yToMove = distanceToMove * sin(bulletBody.zRotation)
        
        playerPhantomX.position = CGPoint(x: xToMove, y: 0)
        playerPhantomY.position = CGPoint(x: 0, y: yToMove)        
    }

    override func moveBullet(distance: CGFloat) {
        canMoveX = true
        canMoveY = true
        for item in (playerPhantomX.physicsBody?.allContactedBodies())!{
            if item.node is Wall{
                canMoveX = false
                break
            }   
        }
        for item in (playerPhantomY.physicsBody?.allContactedBodies())!{
            if item.node is Wall{
                canMoveY = false
                break
            }
            
            
        }
        
        if (!canMoveX || !canMoveY) && !isDeadEnd{ //set ownerWarpPosition one time only
            isDeadEnd = true
            ownerWarpPosition = position
            
        }
        else if (currentTravelDistance > maxDistance) && isDeadEnd{
            owner.position = ownerWarpPosition
            removeFromParent()
        }
        else if currentTravelDistance > maxDistance{
            owner.position = position
            removeFromParent()
        }
        else{
            position.x += xToMove
            position.y += yToMove
            currentTravelDistance += distanceToMove
        }
        
    }
    
    override func hits(something: SKSpriteNode) {
        if something is Wall{
            owner.position = ownerWarpPosition
            removeFromParent()
        }
    }
    
    
    
}
