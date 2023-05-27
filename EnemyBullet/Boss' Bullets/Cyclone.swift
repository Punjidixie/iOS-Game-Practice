//
//  Cyclone.swift
//  Practice
//
//  Created by Siraphop Rungtragoolchai on 16/9/19.
//  Copyright © 2019 Siraphop Rungtragoolchai. All rights reserved.
//

import Foundation
import SpriteKit

class Cyclone: EnemyBullet{
    
    let lifetime : TimeInterval = 3
    var timePassed : TimeInterval = 0
    
    let diameterIncreaseRate : CGFloat = 1600 //pts per second
    let maxDiameter : CGFloat = 800
    
    let suctionSpeed : CGFloat = 600
    var distanceToSucc : CGFloat = 0
    
    var target : Player!
    override init(){
        super.init()
        
        bulletBody.texture = SKTexture(imageNamed: "DarkgreyCircleArrow")
        damage = 0
        size = CGSize(width: 25, height: 25)
        bulletBody.size = size
        movementSpeed = 125
        maxDistance = 700
        zPosition = 1
        setPhysicsBody(circleOfRadius: size.width / 2)
    }
    
    override func updateBullet(deltaFrameTime: TimeInterval){
        distanceToMove = movementSpeed * CGFloat(deltaFrameTime)
        distanceToSucc = suctionSpeed * CGFloat(deltaFrameTime)
        
        if currentTravelDistance > maxDistance{
            let addedDiameter = CGFloat(deltaFrameTime) * diameterIncreaseRate
            size.width += addedDiameter
            size.height += addedDiameter
            if size.width > maxDiameter{
                size.width = maxDiameter
                size.height = maxDiameter
            }
            bulletBody.size = size
            setPhysicsBody(circleOfRadius: size.width / 2)
            timePassed += deltaFrameTime
        }
        
        if timePassed > lifetime{
            if target != nil{
                target.frozen = false
            }
            removeFromParent()
        }
        
        
        
    }
    
    override func moveBullet(distance: CGFloat){ //called in didSimulatedPhysics(), usually got input as self.distanceToMove
        if currentTravelDistance <= maxDistance{
            position.x += distance * cos(bulletBody.zRotation)
            position.y += distance * sin(bulletBody.zRotation)
            currentTravelDistance += distance
        }
 
    }
    
    override func hits(something: SKSpriteNode) {
        
    }
    
    override func affectsPlayer(player: Player) {
        target = player
        if currentTravelDistance > maxDistance{
            target.frozen = true
            let distanceToCenter = sqrt(pow(target.position.x - position.x, 2) + pow(target.position.y - position.y, 2))
            if distanceToSucc > distanceToCenter{
                distanceToSucc = distanceToCenter
            }
            let movementAngle = atan2(position.y - target.position.y, position.x - target.position.x)
            target.forceMove(distance: distanceToSucc, angle: movementAngle)
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
