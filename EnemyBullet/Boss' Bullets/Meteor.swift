//
//  Meteor.swift
//  Practice
//
//  Created by Siraphop Rungtragoolchai on 18/9/19.
//  Copyright © 2019 Siraphop Rungtragoolchai. All rights reserved.
//

import Foundation
import SpriteKit

class Meteor: EnemyBullet{
    
    override init(){
        super.init()
        bulletBody.texture = SKTexture(imageNamed: "DarkgreyCircleArrow")
        damage = 50
        size = CGSize(width: 200, height: 200)
        bulletBody.size = size
        movementSpeed = CGFloat(3000)
        maxDistance = CGFloat(6000)
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


