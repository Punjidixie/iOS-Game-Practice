//
//  SuicideEnemy.swift
//  Practice
//
//  Created by Siraphop Rungtragoolchai on 20/9/19.
//  Copyright © 2019 Siraphop Rungtragoolchai. All rights reserved.
//

import Foundation
import SpriteKit

class SuicideEnemy: Enemy{
    
    let minDistance : CGFloat = 150
    var ignited = false
    
    override init(){
        super.init()
        enemyBody.texture = SKTexture(imageNamed: "Lampy")
        
        size = CGSize(width: 150, height: 150)
        enemyBody.size = size
        setPhysicsBody(circleOfRadius: size.width / 2)
        
        movementSpeed = 600
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func updateEnemy(deltaFrameTime: TimeInterval){
        super.updateEnemy(deltaFrameTime: deltaFrameTime)
        distanceToMove = movementSpeed * CGFloat(deltaFrameTime)  
    }
    
    override func moveEnemy(distance: CGFloat){ //called in didSimulatedPhysics()
        
        let distanceToTarget = sqrt(pow(position.y - target.position.y, 2) + pow(position.x - target.position.x, 2))
        
        if ignited{
            let summonBang = SKAction.run{
                let bang = Bang()
                bang.position = self.position
                bang.owner = self
                self.parent?.addChild(bang)
                self.removeFromParent()
            }
            let fuseTimeWait = SKAction.wait(forDuration: 1)
            let removeFromParentAction = SKAction.run {
                self.removeFromParent()
            }
            run(SKAction.sequence([fuseTimeWait, summonBang, removeFromParentAction]))
        }
        
        else if distanceToTarget >= minDistance{
            enemyBody.zRotation = atan2(target.position.y - position.y, target.position.x - position.x)
            position.x += distance * cos(enemyBody.zRotation)
            position.y += distance * sin(enemyBody.zRotation)
        }
        
        else if distanceToTarget < minDistance{
            ignited = true
        }
        
        
    }
    
    override func shoot(){
        
    }
    
    
    
}
