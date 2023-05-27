//
//  BossEyeBullet.swift
//  Practice
//
//  Created by Siraphop Rungtragoolchai on 20/9/19.
//  Copyright © 2019 Siraphop Rungtragoolchai. All rights reserved.
//

import Foundation
import SpriteKit

class BossEyeBullet: EnemyBullet{
    
    override init(){
        super.init()
        bulletBody.texture = SKTexture(imageNamed: "DarkgreyCircleArrow")
        damage = 10
        size = CGSize(width: 25, height: 25)
        bulletBody.size = size
        movementSpeed = CGFloat(900)
        maxDistance = CGFloat(3000)
        
        setPhysicsBody(rectangleOf: size)
    }
    
    override func hits(something: SKSpriteNode) {
        if something is Player{
            removeFromParent()
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

