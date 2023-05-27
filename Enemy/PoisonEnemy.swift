//
//  PoisonEnemy.swift
//  Practice
//
//  Created by Siraphop Rungtragoolchai on 20/9/19.
//  Copyright © 2019 Siraphop Rungtragoolchai. All rights reserved.
//

import Foundation
import SpriteKit

class PoisonEnemy: Enemy{
    
    let poison = Poison()
    let minDistance : CGFloat = 200
    
    
    override init(){
        super.init()
        enemyBody.texture = SKTexture(imageNamed: "Blank")
        spriteBody.texture = SKTexture(imageNamed: "PoisonEnemy")
        spriteBody.zRotation = 270 * (.pi / 180)
        movementSpeed = 100
        
        size = CGSize(width: 150, height: 150)
        enemyBody.size = size
        spriteBody.size = size
        setPhysicsBody(circleOfRadius: size.width / 2)
        
        poison.position = position
        poison.bulletBody.zRotation = enemyBody.zRotation
        poison.owner = self;
        
        hpLabel.fontColor = SKColor.white
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func updateEnemy(deltaFrameTime: TimeInterval){
        super.updateEnemy(deltaFrameTime: deltaFrameTime)
        distanceToMove = movementSpeed * CGFloat(deltaFrameTime)
        
        if poison.parent == nil{
            parent?.addChild(poison)
        }
        
    }
    
    override func moveEnemy(distance: CGFloat){ //called in didSimulatedPhysics()
        let distanceToTarget = sqrt(pow(position.y - target.position.y, 2) + pow(position.x - target.position.x, 2))
        
        if distanceToTarget >= minDistance{
            enemyBody.zRotation = atan2(target.position.y - position.y, target.position.x - position.x)
            position.x += distance * cos(enemyBody.zRotation)
            position.y += distance * sin(enemyBody.zRotation)
        }
    }
    
    override func shoot(){
        
    }
    
    override func die(){
        poison.removeFromParent()
        removeFromParent()
    }
    
    
    
}

