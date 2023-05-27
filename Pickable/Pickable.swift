//
//  Candy.swift
//  Practice
//
//  Created by Siraphop Rungtragoolchai on 24/9/19.
//  Copyright © 2019 Siraphop Rungtragoolchai. All rights reserved.
//

import Foundation
import SpriteKit

class Pickable: SKSpriteNode{
    
    var movementSpeed = CGFloat(2000) //points per second
    var maxDistance = CGFloat(1000)
    var currentTravelDistance = CGFloat(0)

    let spriteBody = SKSpriteNode(imageNamed: "Lampy")
    
    
    
    var canMoveX = true
    var canMoveY = true
    

    
    init(){
        let texture = SKTexture(imageNamed: "Blank")
        super.init(texture: texture, color: UIColor(), size: texture.size())
        name = "Pickable"
        zPosition = 1
        size = CGSize(width: 50, height: 50)
        spriteBody.size = size
        spriteBody.position = CGPoint(x: 0, y: 0)
        addChild(spriteBody)
        
        setPhysicsBody(circleOfRadius: size.width / 2)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updatePickable(deltaFrameTime: TimeInterval){ //direction of self.zRotation, 1 frame only
        
        
    }

    func checkCollision(){ //called in didSimulatedPhysics()
        parent?.enumerateChildNodes(withName: "Player") { //hitting enemy
            (player, stop) in
            if self.physicsBody!.allContactedBodies().contains(player.physicsBody!){
                self.hits(something: player as! SKSpriteNode)
                self.affectsPlayer(player: player as! Player)
            }
        }
    }
    
    func hits(something : SKSpriteNode){
        if something is Player{
            removeFromParent()
        }
    }
    
    func affectsPlayer(player : Player){
        
    }
    
    func setPhysicsBody(rectangleOf : CGSize){
        physicsBody = SKPhysicsBody(rectangleOf: rectangleOf)
        physicsBody!.affectedByGravity = false;
        physicsBody!.categoryBitMask = PhysicsCategory.Pickable
        physicsBody!.collisionBitMask = PhysicsCategory.None
        physicsBody!.contactTestBitMask = PhysicsCategory.Player
    }
    
    func setPhysicsBody(circleOfRadius : CGFloat){
        physicsBody = SKPhysicsBody(circleOfRadius: circleOfRadius)
        physicsBody!.affectedByGravity = false;
        physicsBody!.categoryBitMask = PhysicsCategory.Pickable
        physicsBody!.collisionBitMask = PhysicsCategory.None
        physicsBody!.contactTestBitMask = PhysicsCategory.Player
    }
    
}

