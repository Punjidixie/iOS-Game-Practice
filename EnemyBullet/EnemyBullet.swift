//
//  EnemyBullet.swift
//  Practice
//
//  Created by Siraphop Rungtragoolchai on 13/9/19.
//  Copyright © 2019 Siraphop Rungtragoolchai. All rights reserved.
//

import Foundation
import SpriteKit

class EnemyBullet: SKSpriteNode{
    
    var movementSpeed = CGFloat(2000) //points per second
    var maxDistance = CGFloat(1000)
    var currentTravelDistance = CGFloat(0)
    var owner : Enemy!
    
    
    let bulletBody = SKSpriteNode(imageNamed: "Lampy")
    
    var xToMove: CGFloat = 0
    var yToMove: CGFloat = 0
    var distanceToMove: CGFloat = 0
    
    var canMoveX = true
    var canMoveY = true
    
    var damage : CGFloat = 1
    
    
    init(){
        let texture = SKTexture(imageNamed: "Blank")
        super.init(texture: texture, color: UIColor(), size: texture.size())
        name = "EnemyBullet"
        zPosition = 4

        bulletBody.position = CGPoint(x: 0, y: 0)
        bulletBody.zPosition = 3
        bulletBody.size = size
        addChild(bulletBody)
        
        setPhysicsBody(rectangleOf: size)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateBullet(deltaFrameTime: TimeInterval){ //direction of self.zRotation, 1 frame only
        distanceToMove = movementSpeed * CGFloat(deltaFrameTime)
        
    }
    
    func moveBullet(distance: CGFloat){ //called in didSimulatedPhysics(), usually got input as self.distanceToMove
        
        position.x += distance * cos(bulletBody.zRotation)
        position.y += distance * sin(bulletBody.zRotation)
        
        currentTravelDistance += distance
        
        if currentTravelDistance > maxDistance{
            removeFromParent()
        }
    }
    
    func checkCollision(){ //called in didSimulatedPhysics()
        parent?.enumerateChildNodes(withName: "Player") { //hitting enemy
            (player, stop) in
            if self.physicsBody!.allContactedBodies().contains(player.physicsBody!){
                self.hits(something: player as! SKSpriteNode)
                self.affectsPlayer(player: player as! Player)
            }  
        }
        parent?.enumerateChildNodes(withName: "Wall") { //hitting enemy
            (wall, stop) in
            if self.physicsBody!.allContactedBodies().contains(wall.physicsBody!){
                self.hits(something: wall as! SKSpriteNode)
            }
        }
    }
    
    func hits(something : SKSpriteNode){
        if something is Wall || something is Player{
            removeFromParent()
        }
    }
    
    func affectsPlayer(player : Player){
        player.deductsHp(hpDeduct : damage)
    }
    
    func setPhysicsBody(rectangleOf : CGSize){
        physicsBody = SKPhysicsBody(rectangleOf: rectangleOf)
        physicsBody!.affectedByGravity = false;
        physicsBody!.categoryBitMask = PhysicsCategory.EnemyBullet
        physicsBody!.collisionBitMask = PhysicsCategory.None
        physicsBody!.contactTestBitMask = PhysicsCategory.Wall | PhysicsCategory.Player
    }
    
    func setPhysicsBody(circleOfRadius : CGFloat){
        physicsBody = SKPhysicsBody(circleOfRadius: circleOfRadius)
        physicsBody!.affectedByGravity = false;
        physicsBody!.categoryBitMask = PhysicsCategory.EnemyBullet
        physicsBody!.collisionBitMask = PhysicsCategory.None
        physicsBody!.contactTestBitMask = PhysicsCategory.Wall | PhysicsCategory.Player
    }
    
}

