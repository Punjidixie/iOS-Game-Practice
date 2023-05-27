//
//  Bomb.swift
//  Practice
//
//  Created by Siraphop Rungtragoolchai on 20/9/19.
//  Copyright © 2019 Siraphop Rungtragoolchai. All rights reserved.
//

import Foundation
import SpriteKit

class Bang: EnemyBullet{
    
    let maxDiameter : CGFloat = 500
    
    let diameterIncreaseRate : CGFloat = 900
    var canHit = true
    
    var target : Player!
    override init(){
        super.init()
        
        bulletBody.texture = SKTexture(imageNamed: "DarkgreyCircleArrow")
        damage = 80
        size = CGSize(width: 25, height: 25)
        bulletBody.size = size
        movementSpeed = 125
        maxDistance = 500
        zPosition = 1
        setPhysicsBody(circleOfRadius: size.width / 2)
    }
    
    override func updateBullet(deltaFrameTime: TimeInterval){
        let addedDiameter = CGFloat(deltaFrameTime) * diameterIncreaseRate
        size.width += addedDiameter
        size.height += addedDiameter
        
        bulletBody.size = size
        setPhysicsBody(circleOfRadius: size.width / 2)
        
        if size.width > maxDiameter{
            removeFromParent()
        }

    }
    
    override func moveBullet(distance: CGFloat){ //called in didSimulatedPhysics(), usually got input as
        
    }
    
    override func hits(something: SKSpriteNode) {
        
    }
    
    override func affectsPlayer(player: Player) {
        if canHit{
            canHit = false
            player.hp -= damage
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
