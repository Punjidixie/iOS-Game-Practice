//
//  Bullet.swift
//  Practice
//
//  Created by Siraphop Rungtragoolchai on 24/6/19.
//  Copyright © 2019 Siraphop Rungtragoolchai. All rights reserved.
//

import Foundation
import SpriteKit

class Bullet: SKSpriteNode{
    
    var movementSpeed = CGFloat(2000) //points per second
    var maxDistance = CGFloat(1000)
    var currentTravelDistance = CGFloat(0)
    var owner : Player!
    
    let bulletBody = SKSpriteNode(imageNamed: "Lampy")
    let spriteBody = SKSpriteNode(imageNamed: "Blank")
    
    var xToMove: CGFloat = 0
    var yToMove: CGFloat = 0
    var distanceToMove: CGFloat = 0
    
    var canMoveX = true
    var canMoveY = true
    
    var damage : CGFloat = 1
    
    
    init(){
        let texture = SKTexture(imageNamed: "Blank")
        super.init(texture: texture, color: UIColor(), size: texture.size())
        name = "Bullet"
        zPosition = 4
        
        spriteBody.position = CGPoint(x: 0, y: 0)
        spriteBody.zPosition = 2
        spriteBody.size = size
        addChild(spriteBody)
        
        bulletBody.position = CGPoint(x: 0, y: 0)
        bulletBody.zPosition = 1
        bulletBody.size = size
        addChild(bulletBody)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateBullet(deltaFrameTime: TimeInterval){ //called in update
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
        
        parent?.enumerateChildNodes(withName: "Enemy") { //hitting enemy
            (enemy, stop) in
            if self.physicsBody!.allContactedBodies().contains(enemy.physicsBody!){
                self.hits(something: enemy as! SKSpriteNode)
                self.affectsEnemy(enemy: enemy as! Enemy)
            }
        }
        parent?.enumerateChildNodes(withName: "Wall") { //hitting enemy
            (wall, stop) in
            if self.physicsBody!.allContactedBodies().contains(wall.physicsBody!){
                
                self.hits(something: wall as! SKSpriteNode)
                self.affectsWall(wall: wall as! Wall)
            }
        }
    }
    
    func hits(something : SKSpriteNode){
        if something is Wall || something is Enemy{
            removeFromParent()
        }
    }
    
    func affectsEnemy(enemy : Enemy){
        enemy.deductsHp(hpDeduct : damage)
    }
    
    func affectsWall(wall : Wall){
        wall.hp -= damage
    }
    
    func setPhysicsBody(rectangleOf : CGSize){
        physicsBody = SKPhysicsBody(rectangleOf: rectangleOf)
        physicsBody!.affectedByGravity = false;
        physicsBody!.categoryBitMask = PhysicsCategory.Bullet
        physicsBody!.collisionBitMask = PhysicsCategory.None
        physicsBody!.contactTestBitMask = PhysicsCategory.Wall | PhysicsCategory.Player | PhysicsCategory.Enemy
    }
    
    func setPhysicsBody(circleOfRadius : CGFloat){
        physicsBody = SKPhysicsBody(circleOfRadius: circleOfRadius)
        physicsBody!.affectedByGravity = false;
        physicsBody!.categoryBitMask = PhysicsCategory.Bullet
        physicsBody!.collisionBitMask = PhysicsCategory.None
        physicsBody!.contactTestBitMask = PhysicsCategory.Wall | PhysicsCategory.Player | PhysicsCategory.Enemy
    }
    
    func removeIfHitWall(){
        for item in (physicsBody?.allContactedBodies())!{
            if item.node is Wall{
                removeFromParent()
                break
            }
        }
    }
    
    func die(){
        removeFromParent()
    }
    
}
