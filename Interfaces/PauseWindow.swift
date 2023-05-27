//
//  PauseWindow.swift
//  Practice
//
//  Created by Siraphop Rungtragoolchai on 30/9/19.
//  Copyright © 2019 Siraphop Rungtragoolchai. All rights reserved.
//

import Foundation
import SpriteKit

class PauseWindow: SKSpriteNode{
    
    
    var textLabel = SKLabelNode(fontNamed: "Avenir Light")
    var continueButton = SKSpriteNode(imageNamed: "WhiteSquare")
    var exitButton = SKSpriteNode(imageNamed: "WhiteSquare")
    var continueLabel = SKLabelNode(fontNamed: "Avenir Light")
    var exitLabel = SKLabelNode(fontNamed: "Avenir Light")
    
    var level : RegularLevel!
    
    init(){
        super.init(texture: SKTexture(imageNamed: "BlueSquare"), color: UIColor(), size: CGSize(width: 0, height: 0))
        size = CGSize(width: 1800, height: 1000)
        
        textLabel.fontSize = 100
        textLabel.position = CGPoint(x: self.size.width * 0, y: self.size.height * 0.3)
        textLabel.fontColor = SKColor.black
        textLabel.text = "Paused"
        textLabel.zPosition = 1
        textLabel.isHidden = false
        addChild(textLabel)
        
        continueButton.size = CGSize(width: 400, height: 200)
        continueButton.position = CGPoint(x: self.size.width * -0.3, y: self.size.height * -0.2)
        continueButton.zPosition = 1
        addChild(continueButton)
        
        exitButton.size = CGSize(width: 400, height: 200)
        exitButton.position = CGPoint(x: self.size.width * 0.3, y: self.size.height * -0.2)
        exitButton.zPosition = 1
        addChild(exitButton)
        
        continueLabel.fontSize = 50
        continueLabel.position = CGPoint(x: 0, y: 0)
        continueLabel.fontColor = SKColor.black
        continueLabel.text = "Continue"
        continueLabel.zPosition = 1
        continueLabel.isHidden = false
        continueButton.addChild(continueLabel)
        
        exitLabel.fontSize = 50
        exitLabel.position = CGPoint(x: 0, y: 0)
        exitLabel.fontColor = SKColor.black
        exitLabel.text = "Exit"
        exitLabel.zPosition = 1
        exitLabel.isHidden = false
        exitButton.addChild(exitLabel)
        
        

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func touchInput(touch : UITouch){
        if continueButton.contains(touch.location(in: self)){
            continueButton.texture = SKTexture(imageNamed: "GreenSquare")
        }
        else if exitButton.contains(touch.location(in: self)){
            exitButton.texture = SKTexture(imageNamed: "GreenSquare")
        }
    }
    
    func touchMoved(touch : UITouch){
        if !continueButton.contains(touch.location(in: self)){
            continueButton.texture = SKTexture(imageNamed: "WhiteSquare")
        }
        if !exitButton.contains(touch.location(in: self)){
            exitButton.texture = SKTexture(imageNamed: "WhiteSquare")
        }
    }
    
    func touchEnded(touch : UITouch){
        if continueButton.contains(touch.location(in: self)){
            level.resumeGame()
            continueButton.texture = SKTexture(imageNamed: "WhiteSquare")
            
        }
        else if exitButton.contains(touch.location(in: self)){
            level.leaveGame()
            exitButton.texture = SKTexture(imageNamed: "WhiteSquare")
        }
    }
    
    
    
}


