//
//  QueBullet.swift
//  Practice
//
//  Created by Siraphop Rungtragoolchai on 29/9/19.
//  Copyright © 2019 Siraphop Rungtragoolchai. All rights reserved.
//

import Foundation
import SpriteKit

class QueBullet: EnemyBullet{
    
    override init(){
        super.init()
        bulletBody.texture = SKTexture(imageNamed: "DarkgreyCircleArrow")
        
        damage = 20
        size = CGSize(width: 40, height: 40)
        
        bulletBody.size = size
        movementSpeed = CGFloat(900)
        
        setPhysicsBody(circleOfRadius: size.width / 2)
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


