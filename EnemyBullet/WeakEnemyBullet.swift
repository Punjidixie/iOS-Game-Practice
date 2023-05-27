//
//  WeakEnemyBullet.swift
//  Practice
//
//  Created by Siraphop Rungtragoolchai on 13/9/19.
//  Copyright © 2019 Siraphop Rungtragoolchai. All rights reserved.
//

import Foundation
import SpriteKit

class WeakEnemyBullet: EnemyBullet{
    
    override init(){
        super.init()
        bulletBody.texture = SKTexture(imageNamed: "WeakEnemyBullet")
        
        damage = 20
        size = CGSize(width: 25, height: 25)
        
        bulletBody.size = size
        movementSpeed = CGFloat(900)
        
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

