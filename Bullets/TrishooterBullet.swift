//
//  TrishooterBullet.swift
//  Practice
//
//  Created by Siraphop Rungtragoolchai on 27/9/19.
//  Copyright © 2019 Siraphop Rungtragoolchai. All rights reserved.
//

import Foundation
import SpriteKit

class TrishooterBullet: Bullet{
    
    override init(){
        super.init()
        bulletBody.texture = SKTexture(imageNamed: "DarkgreyCircleArrow")
        size = CGSize(width: 40, height: 40)
        bulletBody.size = size
        movementSpeed = CGFloat(900)
        maxDistance = CGFloat(750)
        
        damage = 25
        
        setPhysicsBody(circleOfRadius: size.width / 2)
    }
    
    override func updateBullet(deltaFrameTime: TimeInterval) {
        super.updateBullet(deltaFrameTime: deltaFrameTime)
    }
    
    override func moveBullet(distance: CGFloat) {
        super.moveBullet(distance: distance)
    }
    override func hits(something: SKSpriteNode) {
        if something is Wall || something is Enemy{
            die()
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

