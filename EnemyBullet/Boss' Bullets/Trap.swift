//
//  Trap.swift
//  Practice
//
//  Created by Siraphop Rungtragoolchai on 17/9/19.
//  Copyright © 2019 Siraphop Rungtragoolchai. All rights reserved.
//

import Foundation
import SpriteKit

class Trap: EnemyBullet{
    
    let lifetime : TimeInterval = 5
    var timePassed : TimeInterval = 0
    let radius : CGFloat = 200
    
    var target : Player!
    override init(){
        super.init()
        
        bulletBody.texture = SKTexture(imageNamed: "DarkgreyCircleArrow")
        damage = 0
        
        size = CGSize(width: 600, height: 600)
        bulletBody.size = size
        
        zPosition = 1
        setPhysicsBody(circleOfRadius: radius)
    }
    
    override func updateBullet(deltaFrameTime: TimeInterval){
       timePassed += deltaFrameTime
        if timePassed > lifetime{
            removeFromParent()
        }
    }
    
    override func moveBullet(distance: CGFloat){ //called in didSimulatedPhysics(), usually got input as self.distanceToMove
        
    }
    
    override func hits(something: SKSpriteNode) {
        
    }
    
    override func affectsPlayer(player: Player) {
        target = player
        let distanceToCenter = sqrt(pow(target.position.x - position.x, 2) + pow(target.position.y - position.y, 2))
        let angleToCenter = atan2(target.position.y - position.y, target.position.x - position.x)
        
        if distanceToCenter > radius{
            target.position.x = position.x + radius * cos(angleToCenter)
            target.position.y = position.y + radius * sin(angleToCenter)
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
