//
//  Fragg.swift
//  Practice
//
//  Created by Siraphop Rungtragoolchai on 1/9/19.
//  Copyright © 2019 Siraphop Rungtragoolchai. All rights reserved.
//

import Foundation
import SpriteKit

class Fragg: Bullet{
    
    override init(){
        super.init()
        bulletBody.texture = SKTexture(imageNamed: "DarkgreyCircleArrow")
        size = CGSize(width: 25, height: 25)
        bulletBody.size = size
        
        movementSpeed = CGFloat(900)
        maxDistance = CGFloat(1000)
        
        damage = 6
        
        setPhysicsBody(circleOfRadius: size.width / 2)
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
