//
//  EnergyBar.swift
//  Practice
//
//  Created by Siraphop Rungtragoolchai on 28/9/19.
//  Copyright © 2019 Siraphop Rungtragoolchai. All rights reserved.
//

import Foundation
import SpriteKit

class EnergyBar: SKSpriteNode{
    
    let progressBar = SKSpriteNode(imageNamed: "BlueSquare")
    let energyLabel = SKLabelNode(fontNamed: "Avenir Next Ultra Light")
    var maxEnergy : CGFloat = 0

    init(maxEnergy : CGFloat){
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
        
        energyLabel.fontSize = 40
        energyLabel.fontColor = SKColor.black
        energyLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.right
        energyLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        energyLabel.position = CGPoint(x: 250, y: 0)
        energyLabel.zPosition = 1
        addChild(energyLabel)
        energyLabel.text = "\(Int(floor(maxEnergy)))"
        
        self.maxEnergy = maxEnergy
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateEnergyBar(energy: CGFloat){
        let energyRatio = energy / maxEnergy
        if energyRatio == 1{
            progressBar.texture = SKTexture(imageNamed: "BlueSquare")
        }
        else if energyRatio > 2/3{
            progressBar.texture = SKTexture(imageNamed: "GreenSquare")
        }
        else if energyRatio > 1/3{
            progressBar.texture = SKTexture(imageNamed: "YellowSquare")
        }
        else{
            progressBar.texture = SKTexture(imageNamed: "RedSquare")
        }
        progressBar.size = CGSize(width: size.width * (energy/maxEnergy), height: size.height)
        energyLabel.text = "\(Int(floor(energy)))"
        
    }
   
    
    
    
    
}


