//
//  CharacterSelector.swift
//  Practice
//
//  Created by Siraphop Rungtragoolchai on 8/9/19.
//  Copyright © 2019 Siraphop Rungtragoolchai. All rights reserved.
//

import Foundation
import SpriteKit

class CharacterSelector: SKSpriteNode{
    
    let lampyLabel = SKLabelNode(fontNamed: "Avenir Light")
    let leonardoLabel = SKLabelNode(fontNamed: "Avenir Light")
    let catcherLabel = SKLabelNode(fontNamed: "Avenir Light")
    let warperLabel = SKLabelNode(fontNamed: "Avenir Light")
    
    let lampyButton = SKSpriteNode()
    let leonardoButton = SKSpriteNode()
    let catcherButton = SKSpriteNode()
    let warperButton = SKSpriteNode()
    
    var target : Player?
    var gameContentNode : GameContentNode!
    
    
    init(){
        super.init(texture: SKTexture(imageNamed: "Blank"), color: UIColor(), size: CGSize(width: 0, height: 0))
        
        lampyLabel.text = "Lampy"
        leonardoLabel.text = "Leonardo"
        catcherLabel.text = "Catcher"
        warperLabel.text = "Warper"
        
        size = CGSize(width: 100, height: 100)
        
        lampyButton.size = CGSize(width: 200, height: 100)
        lampyButton.position = CGPoint(x: 200, y: 200)
        catcherButton.size = CGSize(width: 200, height: 100)
        catcherButton.position = CGPoint(x: 450, y: 200)
        leonardoButton.size = CGSize(width: 200, height: 100)
        leonardoButton.position = CGPoint(x: 700, y: 200)
        warperButton.size = CGSize(width: 200, height: 100)
        warperButton.position = CGPoint(x: 950, y: 200)
        
        
        lampyLabel.fontSize = 50
        lampyLabel.fontColor = SKColor.black
        lampyLabel.position = CGPoint(x: 200, y: 100)
        
        catcherLabel.fontSize = 50
        catcherLabel.fontColor = SKColor.black
        catcherLabel.position = CGPoint(x: 450, y: 100)
        
        leonardoLabel.fontSize = 50
        leonardoLabel.fontColor = SKColor.black
        leonardoLabel.position = CGPoint(x: 700, y: 100)
        
        warperLabel.fontSize = 50
        warperLabel.fontColor = SKColor.black
        warperLabel.position = CGPoint(x: 950, y: 100)
        
        lampyButton.texture = SKTexture(imageNamed: "WhiteSquare")
        catcherButton.texture = SKTexture(imageNamed: "WhiteSquare")
        leonardoButton.texture = SKTexture(imageNamed: "WhiteSquare")
        warperButton.texture = SKTexture(imageNamed: "WhiteSquare")
        
        addChild(lampyLabel)
        addChild(leonardoLabel)
        addChild(catcherLabel)
        addChild(warperLabel)
        
        addChild(lampyButton)
        addChild(leonardoButton)
        addChild(catcherButton)
        addChild(warperButton)
        
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func touchInput(touch : UITouch){
        
        let pointOfTouch = touch.location(in: self)
        let pos = gameContentNode.player.position
        let angle = gameContentNode.player.playerBody.zRotation
        
        if lampyButton.contains(pointOfTouch){
            
            gameContentNode.player.removeFromParent()
            gameContentNode.player = Lampy()
            gameContentNode.player.position = pos
            gameContentNode.player.playerBody.zRotation = angle
            gameContentNode.addChild(gameContentNode.player)
        }
        else if catcherButton.contains(pointOfTouch){
            
            gameContentNode.player.removeFromParent()
            gameContentNode.player = Catcher()
            gameContentNode.player.position = pos
            gameContentNode.player.playerBody.zRotation = angle
            gameContentNode.addChild(gameContentNode.player)
        }
        else if leonardoButton.contains(pointOfTouch){
            gameContentNode.player.removeFromParent()
            gameContentNode.player = Leonardo()
            gameContentNode.player.position = pos
            gameContentNode.player.playerBody.zRotation = angle
            gameContentNode.addChild(gameContentNode.player)
        }
        
        else if warperButton.contains(pointOfTouch){
            gameContentNode.player.removeFromParent()
            gameContentNode.player = Warper()
            gameContentNode.player.position = pos
            gameContentNode.player.playerBody.zRotation = angle
            gameContentNode.addChild(gameContentNode.player)
        }
    }
   
}
