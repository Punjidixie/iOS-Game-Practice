//
//  TargetLine.swift
//  Practice
//
//  Created by Siraphop Rungtragoolchai on 17/9/19.
//  Copyright © 2019 Siraphop Rungtragoolchai. All rights reserved.
//

import Foundation
import SpriteKit

class TargetLine: EnemyBullet{
    
    var timePassed : TimeInterval = 0
    let lifetime : TimeInterval = 1
    
    init(angle : CGFloat){
        super.init()
        texture = SKTexture(imageNamed: "BlueSquare")
        zRotation = angle
        bulletBody.texture = SKTexture(imageNamed: "Blank")
        damage = 0
        size = CGSize(width: 6000, height: 15)
        bulletBody.size = size
        
        setPhysicsBody(rectangleOf: size)
    }
    
    override func updateBullet(deltaFrameTime: TimeInterval) {
        timePassed += deltaFrameTime
        if timePassed > lifetime{
            removeFromParent()
        }
    }
    override func hits(something: SKSpriteNode) {
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

