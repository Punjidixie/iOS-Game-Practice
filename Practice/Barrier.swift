//
//  Barrier.swift
//  Practice
//
//  Created by Siraphop Rungtragoolchai on 21/9/19.
//  Copyright © 2019 Siraphop Rungtragoolchai. All rights reserved.
//

import Foundation
import SpriteKit

class Barrier: Wall{
    
    
    override init(){
        super.init()
        texture = SKTexture(imageNamed: "BlueSquare")

        
        size = CGSize(width: 2048, height: 1536)
        zPosition = 2
        zRotation = 0
        physicsBody = SKPhysicsBody(rectangleOf: self.size)
        physicsBody!.affectedByGravity = false;
        physicsBody!.categoryBitMask = PhysicsCategory.Wall
        physicsBody!.collisionBitMask = PhysicsCategory.None
        physicsBody!.contactTestBitMask = PhysicsCategory.PlayerPhantom | PhysicsCategory.Player | PhysicsCategory.Bullet
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateWall(deltaFrameTime: TimeInterval){
        
    }
    override func hitBy(something : SKSpriteNode){
        
    }
    
}

