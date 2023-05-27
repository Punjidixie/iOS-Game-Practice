//
//  Thicc.swift
//  Practice
//
//  Created by Siraphop Rungtragoolchai on 24/6/19.
//  Copyright © 2019 Siraphop Rungtragoolchai. All rights reserved.
//

import Foundation
import SpriteKit

class Thicc: Bullet{
    
    let fraggSpread: CGFloat = 120*(.pi/180)
    
    override init(){
        super.init()
        bulletBody.texture = SKTexture(imageNamed: "DarkgreyCircleArrow")
        size = CGSize(width: 75, height: 75)
        bulletBody.size = size
        movementSpeed = CGFloat(900)
        maxDistance = CGFloat(500)
        
        damage = 40
        
        setPhysicsBody(circleOfRadius: size.width / 2)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateBullet(deltaFrameTime: TimeInterval){
        distanceToMove = movementSpeed * CGFloat(deltaFrameTime)
    }
    
    override func hits(something: SKSpriteNode) {
        if something is Wall || something is Enemy{
            die()
        }
    }
    
    override func moveBullet(distance: CGFloat){
        
        
        position.x += distance * cos(bulletBody.zRotation)
        position.y += distance * sin(bulletBody.zRotation)
        
        currentTravelDistance += distance
        
        if currentTravelDistance > maxDistance{
            let firstBulletAngle : CGFloat = bulletBody.zRotation - (fraggSpread / 2)
            for i in 0...6{
               let fragg = Fragg()
                fragg.bulletBody.zRotation = firstBulletAngle + CGFloat(i) * (fraggSpread / 6)
                fragg.position = position
                fragg.owner = owner;
                parent?.addChild(fragg)
                if i == -3{
                    fragg.run(SKAction.playSoundFileNamed("LampyHarp2", waitForCompletion: false))
                }
            }
            removeFromParent()
            
        }
    }
    
}
