//
//  PlayerPhantom.swift
//  Practice
//
//  Created by Siraphop Rungtragoolchai on 24/6/19.
//  Copyright © 2019 Siraphop Rungtragoolchai. All rights reserved.
//

import Foundation
import SpriteKit

class PlayerPhantom: SKSpriteNode, SKPhysicsContactDelegate{
    
    let diameter : CGFloat = 150
    
    init(){
        let texture = SKTexture(imageNamed: "Blank")
        // you have no choice but to call this super class init method for some reason
        super.init(texture: texture, color: UIColor(), size: texture.size())
        
        setScale(1)
        
        physicsBody = SKPhysicsBody(circleOfRadius: diameter / 2)
        physicsBody!.affectedByGravity = false;
        physicsBody!.categoryBitMask = PhysicsCategory.PlayerPhantom;
        physicsBody!.collisionBitMask = PhysicsCategory.None;
        physicsBody!.contactTestBitMask = PhysicsCategory.Wall;
        
        isHidden = false
    }
    
    init(circleOfRadius : CGFloat){
        let texture = SKTexture(imageNamed: "Blank")
        // you have no choice but to call this super class init method for some reason
        super.init(texture: texture, color: UIColor(), size: texture.size())
        
        setScale(1)
        
        physicsBody = SKPhysicsBody(circleOfRadius: circleOfRadius)
        physicsBody!.affectedByGravity = false;
        physicsBody!.categoryBitMask = PhysicsCategory.PlayerPhantom;
        physicsBody!.collisionBitMask = PhysicsCategory.None;
        physicsBody!.contactTestBitMask = PhysicsCategory.Wall;
        
        isHidden = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
