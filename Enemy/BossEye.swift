//
//  BossEye.swift
//  Practice
//
//  Created by Siraphop Rungtragoolchai on 15/9/19.
//  Copyright © 2019 Siraphop Rungtragoolchai. All rights reserved.
//

import Foundation
import SpriteKit

class BossEye: Enemy{
    var cooldownTime : TimeInterval = 10
    let attack2Spread : CGFloat = 45*(.pi/180)
    var isFollowingPlayer = false
    var moving = true
    let maxTravelDistance : CGFloat = 600
    var currentTravelDistance : CGFloat = 0
    
    override init(){
        super.init()
        movementSpeed = 100
        
        enemyBody.texture = SKTexture(imageNamed: "Boss")
        size = CGSize(width: 500, height: 500)
        enemyBody.size = size
        enemyBody.zRotation = 270 * (.pi/180)
        setPhysicsBody(circleOfRadius : size.width/2)
        
        hp = 1000
        maxHp = 1000
        hpBar.maxHp = maxHp
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func updateEnemy(deltaFrameTime: TimeInterval){
        super.updateEnemy(deltaFrameTime: deltaFrameTime)
        
        if hp < maxHp / 2{
            enemyBody.texture = SKTexture(imageNamed: "BossHurt")
        }
        if moving{
            distanceToMove = CGFloat(deltaFrameTime) * movementSpeed
        }
        
        if isFollowingPlayer{
            enemyBody.zRotation = atan2(target.position.y - position.y, target.position.x - position.x)
        }
        else{
            enemyBody.zRotation = 270 * (.pi/180)
        }
        
        cooldownTime -= deltaFrameTime
        
        if cooldownTime < 0{
            let chanceNumber = Int.random(in: 0...100)
            if chanceNumber >= 80{
                attack1()
                cooldownTime = 7
            }
            else if chanceNumber >= 60{
                attack2()
                cooldownTime = 7
            }
            else if chanceNumber >= 40{
                let waitAction = SKAction.wait(forDuration: 6)
                let doAttack2 = SKAction.run {
                    self.attack2()
                }
                let doAttack3 = SKAction.run {
                    self.attack3()
                }
                run(SKAction.sequence([doAttack3, waitAction, doAttack2]))
                cooldownTime = 13.5
            }
            else if chanceNumber >= 20{
                attack4()
                cooldownTime = 7
            }
            else if chanceNumber >= 0{
                attack5()
                cooldownTime = 7
            }
        }
    }
    
    override func moveEnemy(distance: CGFloat){ //called in didSimulatedPhysics()
        if moving{
            position.y -= distance
            currentTravelDistance += distance
        }
        
        if currentTravelDistance > maxTravelDistance{
            moving = false
        }
        
        
        
    }
    
    override func shoot(){
        let bullet = WeakEnemyBullet()
        bullet.position = position
        bullet.bulletBody.zRotation = enemyBody.zRotation
        bullet.owner = self;
        parent?.addChild(bullet)
    }
    
    func attack1(){ // shooting continuous bullets, rotates with player (takes 3 seconds)
        isFollowingPlayer = true
        var round : Double = 0
        for _ in 0...20{
            let waitAction = SKAction.wait(forDuration: 0.15 * round)
            let shootABullet = SKAction.run{
                let bullet = BossEyeBullet()
                bullet.position = self.position
                bullet.bulletBody.zRotation = self.enemyBody.zRotation
                bullet.owner = self;
                self.parent?.addChild(bullet)
            }
            let sequence = SKAction.sequence([waitAction, shootABullet])
            run(sequence)
            round += 1
        }
        let unfollowAction = SKAction.run{
            self.isFollowingPlayer = false
        }
        run(SKAction.sequence([SKAction.wait(forDuration: 0.15 * round), unfollowAction]))
        
    }
    
    func attack2(){ // shooting continuous bullets, rotates with player (take 3 seconds)
        isFollowingPlayer = false
        var round : Double = 0
        for _ in 0...20{
            let waitAction = SKAction.wait(forDuration: 0.15 * round)
            let shoot3bullets = SKAction.run{
                let bullet1 = BossEyeBullet()
                let bullet2 = BossEyeBullet()
                let bullet3 = BossEyeBullet()
                bullet1.position = self.position
                bullet2.position = self.position
                bullet3.position = self.position
                bullet1.bulletBody.zRotation = self.enemyBody.zRotation - self.attack2Spread / 2
                bullet2.bulletBody.zRotation = self.enemyBody.zRotation
                bullet3.bulletBody.zRotation = self.enemyBody.zRotation + self.attack2Spread / 2
                bullet1.owner = self;
                bullet2.owner = self;
                bullet3.owner = self;
                self.parent?.addChild(bullet1)
                self.parent?.addChild(bullet2)
                self.parent?.addChild(bullet3)
            }
            let sequence = SKAction.sequence([waitAction, shoot3bullets])
            run(sequence)
            round += 1
        }
        let unfollowAction = SKAction.run{
            self.isFollowingPlayer = false
        }
        run(SKAction.sequence([SKAction.wait(forDuration: 0.15 * round), unfollowAction]))
        
    }
    
    func attack3(){ // cyclone
        let cyclone = Cyclone()
        cyclone.position = position
        cyclone.bulletBody.zRotation = 270 * (.pi/180)
        cyclone.owner = self;
        parent?.addChild(cyclone)
        
    }
    
    func attack4(){ // trap
        let trap = Trap()
        trap.position = target.position
        trap.owner = self;
        parent?.addChild(trap)
        
    }
    
    func attack5(){ //target line

        for i in 0...2{
            let degree1 = Int.random(in: 290 ... 340)
            let elevation1 = Int.random(in: 750 ... 1536)
            
            let degree2 = Int.random(in: 200 ... 250)
            let elevation2 = Int.random(in: 750 ... 1536)
            
            let showTargetLine = SKAction.run {
                let targetLine1 = TargetLine(angle : CGFloat(degree1) * (.pi / 180))
                targetLine1.position = CGPoint(x: 0, y: elevation1)
                self.parent?.addChild(targetLine1)
                
                let targetLine2 = TargetLine(angle : CGFloat(degree2) * (.pi / 180))
                targetLine2.position = CGPoint(x: 2048, y: elevation2)
                self.parent?.addChild(targetLine2)
            }
            let waitAction = SKAction.wait(forDuration: 1)
            
            let summonMeteor = SKAction.run {
                let meteor1 = Meteor()
                let meteor2 = Meteor()
                //let bufferDistance : CGFloat = 100
                meteor1.position = CGPoint(x: 0, y: elevation1)
                meteor1.bulletBody.zRotation = CGFloat(degree1) * (.pi/180)
                self.parent?.addChild(meteor1)
                
                meteor2.bulletBody.zRotation = CGFloat(degree2) * (.pi/180)
                meteor2.position = CGPoint(x: 2048, y: elevation2)
                self.parent?.addChild(meteor2)
            }
            
            let waitForTurn = SKAction.wait(forDuration: TimeInterval(Double(i) * 1.5))
            run(SKAction.sequence([waitForTurn,showTargetLine, waitAction, summonMeteor]))
        }
        
        
    }
    
    
    
}
