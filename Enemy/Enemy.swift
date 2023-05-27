//
//  Enemy.swift
//  Practice
//
//  Created by Siraphop Rungtragoolchai on 13/9/19.
//  Copyright © 2019 Siraphop Rungtragoolchai. All rights reserved.
//

import Foundation
import SpriteKit

class Enemy: SKSpriteNode, SKPhysicsContactDelegate{
    
    var movementSpeed = CGFloat(0) //points per second
    var canMoveX = true
    var canMoveY = true
    
    var enemyBody = SKSpriteNode(imageNamed: "Blank")
    let spriteBody = SKSpriteNode(imageNamed: "Blank")
    var target : Player!
    
    var maxHp : CGFloat = 100
    var hp : CGFloat = 100
    
    var xToMove: CGFloat = 0
    var yToMove: CGFloat = 0
    var distanceToMove: CGFloat = 0
    
    let hpLabel = SKLabelNode(fontNamed: "Avenir Light")
    let hpBar = HealthBar(maxHp: 100)
    
    var spriteCooldown : TimeInterval = 0
    
    init(){
        let texture = SKTexture(imageNamed: "Blank")
        super.init(texture: texture, color: UIColor(), size: texture.size())
        name = "Enemy"
        
        setScale(1) //size, setup
        size = CGSize(width: 200, height: 200)
        zPosition = 2
        zRotation = 0
        
        hpBar.position = CGPoint(x: -size.width / 2, y: size.height / 2 + 25)
        initMaxHp(maxHp: 100)
        addChild(hpBar)
        
        setPhysicsBody(circleOfRadius : size.width/2)
        
        enemyBody.position = CGPoint(x: 0, y: 0) //enemyBody setup
        enemyBody.zPosition = 3
        enemyBody.size = size
        addChild(enemyBody)
        
        spriteBody.position = CGPoint(x: 0, y: 0)
        spriteBody.zPosition = 4
        spriteBody.size = size
        addChild(spriteBody)
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func updateEnemy(deltaFrameTime: TimeInterval){
        if hp <= 0{
            hp = 0
            die()
        }
        hpBar.updateHpBar(hp: hp)
        
        spriteCooldown -= deltaFrameTime
        if spriteCooldown <= 0{
            spriteCooldown = 0
            spriteBody.zRotation = enemyBody.zRotation
        }
        
    }

    
    func moveEnemy(distance: CGFloat){ //called in didSimulatedPhysics()
       if spriteCooldown <= 0{
           spriteCooldown = 0
           spriteBody.zRotation = enemyBody.zRotation
       }
    }
    
    func shoot(){
        
    }
    
    func die(){
        removeFromParent()
    }
    
    func deductsHp(hpDeduct : CGFloat){
        hp -= hpDeduct
    }
    
    func setPhysicsBody(circleOfRadius : CGFloat){
        physicsBody = SKPhysicsBody(circleOfRadius: circleOfRadius)
        physicsBody!.affectedByGravity = false
        physicsBody!.categoryBitMask = PhysicsCategory.Enemy
        physicsBody!.collisionBitMask = PhysicsCategory.None
        physicsBody!.contactTestBitMask = PhysicsCategory.Bullet | PhysicsCategory.Player
    }
    
    func setPhysicsBody(rectangleOf : CGSize){
        physicsBody = SKPhysicsBody(rectangleOf: rectangleOf)
        physicsBody!.affectedByGravity = false
        physicsBody!.categoryBitMask = PhysicsCategory.Enemy
        physicsBody!.collisionBitMask = PhysicsCategory.None
        physicsBody!.contactTestBitMask = PhysicsCategory.Bullet | PhysicsCategory.Player
    }
    
    func initMaxHp(maxHp : CGFloat){
        self.maxHp = maxHp
        self.hp = maxHp
        hpBar.maxHp = maxHp
        hpBar.updateHpBar(hp: maxHp)
    }
}

