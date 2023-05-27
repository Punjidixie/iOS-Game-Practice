//
//  PauseButton.swift
//  Practice
//
//  Created by Siraphop Rungtragoolchai on 30/9/19.
//  Copyright © 2019 Siraphop Rungtragoolchai. All rights reserved.
//

import Foundation
import SpriteKit

class PauseButton: SKSpriteNode{
    
    
    var level : RegularLevel!
    var target : Player!
    var touchBoss = UITouch()
    var textLabel = SKLabelNode(fontNamed: "Avenir Light")
    
    let radius : CGFloat = 75
    
    var active = false
    var locked = false
    
    enum buttonState{
        case inactive
        case active
    }
    
    
    init(){
        super.init(texture: SKTexture(imageNamed: "WhiteSquare"), color: UIColor(), size: CGSize(width: 0, height: 0))
        
        size = CGSize(width: 200, height: 100)
        alpha = 0.7
        
        textLabel.fontSize = 50
        textLabel.position = CGPoint(x: self.size.width * 0, y: self.size.height * 0)
        textLabel.fontColor = SKColor.black
        textLabel.text = "Pause"
        textLabel.zPosition = 1
        textLabel.isHidden = false
        addChild(textLabel)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func touchInput(touch : UITouch){
        if !active{
            touchBoss = touch
            texture = SKTexture(imageNamed: "GreenSquare")
        }
    }
    
    func touchMoved(touch : UITouch){
        if touch == touchBoss{
            
        }
    }
    
    func touchEnded(touch : UITouch){
        if touch == touchBoss{
            if self.contains(touch.location(in: parent!)){
                level.pauseGame()
            }
            texture = SKTexture(imageNamed: "WhiteSquare")
            active = false
        }
    }
    
    
    
}

