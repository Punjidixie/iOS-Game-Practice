//
//  Player.swift
//  Practice
//
//  Created by Siraphop Rungtragoolchai on 24/6/19.
//  Copyright © 2019 Siraphop Rungtragoolchai. All rights reserved.
//

import Foundation
import SpriteKit

class Wall: SKSpriteNode{
    
    var hp : CGFloat = 100
    let movementSpeed = CGFloat(300) //points per second
    let hpLabel = SKLabelNode(fontNamed: "Avenir Light")
    init(){
        let texture = SKTexture(imageNamed: "BlueSquare")
        // you have no choice but to call this super class init method for some reason
        super.init(texture: texture, color: UIColor(), size: texture.size())
        self.name = "Wall"
        
        hpLabel.fontSize = 50
        hpLabel.fontColor = SKColor.black
        hpLabel.position = CGPoint(x: 0, y: 0)
        hpLabel.zPosition = 1
        hpLabel.text = "\(Int(hp))"
        addChild(hpLabel)
        
        
        setScale(1)
        size = CGSize(width: 400, height: 400)
        zPosition = 2
        zRotation = 0
        physicsBody = SKPhysicsBody(rectangleOf: self.size)
        physicsBody!.affectedByGravity = false;
        physicsBody!.categoryBitMask = PhysicsCategory.Wall
        physicsBody!.collisionBitMask = PhysicsCategory.None
        physicsBody!.contactTestBitMask = PhysicsCategory.PlayerPhantom | PhysicsCategory.Player | PhysicsCategory.Bullet
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateWall(deltaFrameTime: TimeInterval){
        hpLabel.text = "\(Int(hp))"
        if hp <= 0{
            hp = 0
            removeFromParent()
        }
    }
    func hitBy(something : SKSpriteNode){
        /*if something is Bullet{
            hp -= (something as! Bullet).damage
            hpLabel.text = "\(Int(hp))"
            if hp == 0{
                removeFromParent()
            }
        }*/
    }
    
}
