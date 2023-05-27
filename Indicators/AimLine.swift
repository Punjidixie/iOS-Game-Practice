//
//  AimLine.swift
//  Practice
//
//  Created by Siraphop Rungtragoolchai on 23/9/19.
//  Copyright © 2019 Siraphop Rungtragoolchai. All rights reserved.
//

import Foundation
import SpriteKit

class AimLine: SKSpriteNode{
    
    init(){
        let texture = SKTexture(imageNamed: "WhiteSquare")
        // you have no choice but to call this super class init method for some reason
        
        super.init(texture: texture, color: UIColor(), size: texture.size())
        name = "AimLine"
        
        anchorPoint = CGPoint(x: 0, y: 0.5)
        setScale(1) //size, physicsBody setup
        size = CGSize(width: 500, height: 30)
        alpha = 0.7
        zPosition = 200
        zRotation = 0
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
   
    
    
    
    
}

