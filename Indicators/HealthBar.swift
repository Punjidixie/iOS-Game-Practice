//
//  HealthBar.swift
//  Practice
//
//  Created by Siraphop Rungtragoolchai on 22/9/19.
//  Copyright © 2019 Siraphop Rungtragoolchai. All rights reserved.
//

import Foundation
import SpriteKit

class HealthBar: SKSpriteNode{
    
    let progressBar = SKSpriteNode(imageNamed: "BlueSquare")
    let hpLabel = SKLabelNode(fontNamed: "Avenir Next Ultra Light")
    var maxHp : CGFloat = 0

    init(maxHp : CGFloat){
        let texture = SKTexture(imageNamed: "WhiteSquare")
        // you have no choice but to call this super class init method for some reason
        
        super.init(texture: texture, color: UIColor(), size: texture.size())
        name = "HealthBar"
        
        anchorPoint = CGPoint(x: 0, y: 0.5)
        setScale(1) //size, physicsBody setup
        size = CGSize(width: 150, height: 10)
        zPosition = 200
        zRotation = 0
        
        progressBar.size = size
        progressBar.anchorPoint = CGPoint(x: 0, y: 0.5)
        progressBar.position = CGPoint(x: 0, y: 0)
        progressBar.zPosition = 1
        zRotation = 0
        addChild(progressBar)
        
        hpLabel.fontSize = 40
        hpLabel.fontColor = SKColor.black
        hpLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.right
        hpLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        hpLabel.position = CGPoint(x: 250, y: 0)
        hpLabel.zPosition = 1
        addChild(hpLabel)
        hpLabel.text = "\(Int(floor(maxHp)))"
        
        self.maxHp = maxHp
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateHpBar(hp: CGFloat){
        let hpRatio = hp / maxHp
        if hpRatio == 1{
            progressBar.texture = SKTexture(imageNamed: "BlueSquare")
        }
        else if hpRatio > 2/3{
            progressBar.texture = SKTexture(imageNamed: "GreenSquare")
        }
        else if hpRatio > 1/3{
            progressBar.texture = SKTexture(imageNamed: "YellowSquare")
        }
        else{
            progressBar.texture = SKTexture(imageNamed: "RedSquare")
        }
        progressBar.size = CGSize(width: size.width * (hp/maxHp), height: size.height)
        hpLabel.text = "\(Int(floor(hp)))"
        
    }
   
    
    
    
    
}

