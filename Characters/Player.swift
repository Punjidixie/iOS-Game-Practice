//
//  Player.swift
//  Practice
//
//  Created by Siraphop Rungtragoolchai on 24/6/19.
//  Copyright © 2019 Siraphop Rungtragoolchai. All rights reserved.
//

import Foundation
import SpriteKit

class Player: SKSpriteNode, SKPhysicsContactDelegate{
    
    var movementSpeed = CGFloat(300) //points per second
    var energyRecoveryRate = CGFloat(10) //energy per second
    
    var playerBody = SKSpriteNode(imageNamed: "WhiteSquare") //movement body
    var aimingBody = SKSpriteNode(imageNamed: "WhiteSquare") //aiming body
    var spriteBody = SKSpriteNode(imageNamed: "Blank") //aiming body
    
    var aimLine = AimLine()
    
    var playerPhantomX = PlayerPhantom()
    var playerPhantomY = PlayerPhantom()
    
    var xToMove: CGFloat = 0
    var yToMove: CGFloat = 0
    var canMoveX = true
    var canMoveY = true
    var distanceToMove: CGFloat = 0
    
    var maxHp : CGFloat = 1000
    var hp : CGFloat = 1000
    var hpBar = HealthBar(maxHp: 1000)
    
    var maxEnergy : CGFloat = 100
    var energy : CGFloat = 100
    var energyBar = EnergyBar(maxEnergy : 100)
    
    var frozen = false
    var currentPlayerState = playerState.normal
    
    var spriteCooldown : TimeInterval = 0
    var attackCooldown : TimeInterval = 0
    
    
    enum playerState{
        case normal
        case preparingAttack
        case attack
        case attack1
        case attack2
        case dead
    }
    
    init(){
        let texture = SKTexture(imageNamed: "Blank")
        // you have no choice but to call this super class init method for some reason
        
        super.init(texture: texture, color: UIColor(), size: texture.size())
        name = "Player"

        setScale(1) //size, physicsBody setup
        size = CGSize(width: 200, height: 200)
        zPosition = 2
        zRotation = 0
        
        setPhysicsBody(circleOfRadius: size.width / 2)

        playerBody.position = CGPoint(x: 0, y: 0) //playerBody setup
        playerBody.zPosition = 3
        playerBody.size = size
        playerBody.zRotation = 90 * (.pi/180)
        addChild(playerBody)
        
        spriteBody.position = CGPoint(x: 0, y: 0)
        spriteBody.zPosition = 4
        spriteBody.size = size
        spriteBody.zRotation = 90 * (.pi/180)
        addChild(spriteBody)
        
        //playerPhantom setup
        setPlayerPhantoms(circleOfRadius: size.width / 2)
        
        hpBar.position = CGPoint(x: -size.width/2, y: 100)
        addChild(hpBar)
        
        energyBar.position = CGPoint(x: -size.width/2, y: -100)
        addChild(energyBar)
        
        aimLine.position = CGPoint(x: 0, y: 0)
        aimLine.isHidden = true
        addChild(aimLine)
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func updatePlayer(deltaFrameTime: TimeInterval){
        
        energy += energyRecoveryRate * CGFloat(deltaFrameTime)
        if energy > maxEnergy{
            energy = maxEnergy
        }
        if hp <= 0{
            hp = 0
            die()
        }
        
        spriteCooldown -= deltaFrameTime
        if spriteCooldown <= 0{
            spriteCooldown = 0
            spriteBody.zRotation = playerBody.zRotation
        }
        
        attackCooldown -= deltaFrameTime
        if attackCooldown <= 0{
            attackCooldown = 0
            
        }
        

        hpBar.updateHpBar(hp: hp)
        energyBar.updateEnergyBar(energy: energy)
        
    }
    func movePlayerCheck(deltaFrameTime: TimeInterval){ //called in update
        distanceToMove = movementSpeed * CGFloat(deltaFrameTime)
        xToMove = distanceToMove * cos(playerBody.zRotation)
        yToMove = distanceToMove * sin(playerBody.zRotation)
        
        playerPhantomX.position = CGPoint(x: xToMove, y: 0)
        playerPhantomY.position = CGPoint(x: 0, y: yToMove)
    }
    
    func hitBy(something : SKSpriteNode){
        if something is EnemyBullet{
            hp -= (something as! EnemyBullet).damage
        }
    }
    
    func movePlayer(distance: CGFloat){ //called in didSimulatedPhysics()
        canMoveX = true
        canMoveY = true
        for item in (playerPhantomX.physicsBody?.allContactedBodies())!{
            if item.node is Wall{
                canMoveX = false
                break
            }
        }
        for item in (playerPhantomY.physicsBody?.allContactedBodies())!{
            if item.node is Wall{
                canMoveY = false
                break
            }
        }
        
        if canMoveX && !frozen{
            position.x += xToMove
        }
        
        if canMoveY && !frozen{
            position.y += yToMove
        }
        frozen = false
    }
    
    func shoot(){
        
    }
    
    func aimedShoot(angle: CGFloat){
        
    }
    
    func die(){
        currentPlayerState = playerState.dead
    }
    
    func forceMove(distance : CGFloat, angle : CGFloat){
        position.x += distance * cos(angle)
        position.y  += distance * sin(angle)
    }
    
    func deductsHp(hpDeduct : CGFloat){
        hp -= hpDeduct
    }
    
    func setPhysicsBody(circleOfRadius : CGFloat){
        physicsBody = SKPhysicsBody(circleOfRadius: circleOfRadius)
        physicsBody!.affectedByGravity = false;
        physicsBody!.categoryBitMask = PhysicsCategory.Player
        physicsBody!.collisionBitMask = PhysicsCategory.None
        physicsBody!.contactTestBitMask = PhysicsCategory.Wall | PhysicsCategory.Bullet | PhysicsCategory.EnemyBullet | PhysicsCategory.Pickable
    }
    
    func setPhysicsBody(rectangleOf : CGSize){
        physicsBody = SKPhysicsBody(rectangleOf: rectangleOf)
        physicsBody!.affectedByGravity = false;
        physicsBody!.categoryBitMask = PhysicsCategory.Player
        physicsBody!.collisionBitMask = PhysicsCategory.None
        physicsBody!.contactTestBitMask = PhysicsCategory.Wall | PhysicsCategory.Bullet | PhysicsCategory.EnemyBullet | PhysicsCategory.Pickable
    }
    
    func setPlayerPhantoms(circleOfRadius : CGFloat){
        playerPhantomX.removeFromParent()
        playerPhantomY.removeFromParent()
        
        playerPhantomX = PlayerPhantom(circleOfRadius : circleOfRadius)
        playerPhantomY = PlayerPhantom(circleOfRadius : circleOfRadius)
        
        addChild(playerPhantomX)
        playerPhantomX.position = CGPoint(x: 0, y: 0)
        playerPhantomX.zPosition = 0
        
        
        addChild(playerPhantomY)
        playerPhantomY.position = CGPoint(x: 0, y: 0)
        playerPhantomY.zPosition = 0
    }
    
    func initMaxHp(maxHp : CGFloat){
        self.maxHp = maxHp
        self.hp = maxHp
        hpBar.maxHp = maxHp
        hpBar.updateHpBar(hp: maxHp)
    }
    
    func initMaxEnergy(maxEnergy : CGFloat){
        self.maxEnergy = maxEnergy
        self.energy = maxEnergy
        energyBar.maxEnergy = maxEnergy
        energyBar.updateEnergyBar(energy: maxEnergy)
    }
    
    
    
    
    
}
