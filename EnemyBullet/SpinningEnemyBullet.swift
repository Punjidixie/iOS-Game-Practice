//
//  SpinningEnemyBullet.swift
//  Practice
//
//  Created by Siraphop Rungtragoolchai on 20/9/19.
//  Copyright © 2019 Siraphop Rungtragoolchai. All rights reserved.
//

import Foundation
import SpriteKit

class SpinningEnemyBullet: EnemyBullet{
    
    override init(){
        super.init()
        bulletBody.texture = SKTexture(imageNamed: "DarkgreyCircleArrow")
        damage = 40
        size = CGSize(width: 50, height: 50)
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


