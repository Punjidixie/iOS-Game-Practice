//
//  Leonardo.swift
//  Practice
//
//  Created by Siraphop Rungtragoolchai on 24/6/19.
//  Copyright © 2019 Siraphop Rungtragoolchai. All rights reserved.
//

import Foundation
import SpriteKit

class Leonardo: Player{
    
    let bulletSpread: CGFloat = 60*(.pi/180)
    
    override init(){
        super.init()
        playerBody.texture = SKTexture(imageNamed: "leonUnicorn")
        
        size = CGSize(width: 150, height: 150)
        playerBody.size = size
        spriteBody.size = size
        setPhysicsBody(circleOfRadius: size.width / 2)
        
        setPlayerPhantoms(circleOfRadius: size.width / 2)
        
        aimLine.size = CGSize(width: 1000, height: 75)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func shoot(){
        if energy >= 10{
            energy -= 10
            var round : Double = 0
            for i in 0...4{
                let waitAction = SKAction.wait(forDuration: 0.1 * round)
                let shootABullet = SKAction.run{
                    let blade = Blade()
                    blade.position = self.position
                    blade.bulletBody.zRotation = self.playerBody.zRotation - (self.bulletSpread * CGFloat(i - 2)) / 5
                    blade.owner = self;
                    self.parent?.addChild(blade)
                }
                let sequence = SKAction.sequence([waitAction, shootABullet])
                run(sequence)
                round += 1
            }
        }
    }
    
    override func aimedShoot(angle: CGFloat) {
        if energy >= 10{
            spriteBody.zRotation = angle
            energy -= 10
            var round : Double = 0
            for i in 0...4{
                let waitAction = SKAction.wait(forDuration: 0.1 * round)
                let shootABullet = SKAction.run{
                    let blade = Blade()
                    blade.position = self.position
                    blade.bulletBody.zRotation = angle - (self.bulletSpread * CGFloat(i - 2)) / 5
                    blade.owner = self;
                    self.parent?.addChild(blade)
                }
                let sequence = SKAction.sequence([waitAction, shootABullet])
                run(sequence)
                round += 1
            }
        }
    }
    
    
}
