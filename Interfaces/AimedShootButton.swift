//
//  AimedShootButton.swift
//  Practice
//
//  Created by Siraphop Rungtragoolchai on 23/9/19.
//  Copyright © 2019 Siraphop Rungtragoolchai. All rights reserved.
//

import Foundation
import SpriteKit

class AimedShootButton: SKSpriteNode{
    
    
    var gameContentNode : GameContentNode!
    var target : Player!
    var touchBoss = UITouch()
    
    let smallNode = SKSpriteNode(imageNamed: "Joystick Light")
    let radius : CGFloat = 75
    let activeRadius : CGFloat = 50
    
    var active = false
    var hasMovedOut = false //for quick shoot
    
    enum buttonState{
        case inactive
        case active
    }
    
    
    init(){
        super.init(texture: SKTexture(imageNamed: "Joystick Base"), color: UIColor(), size: CGSize(width: 0, height: 0))
        size = CGSize(width: radius * 2, height: radius * 2)
        alpha = 0.7
        
        smallNode.size = size
        smallNode.zPosition = 1
        addChild(smallNode)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func touchInput(touch : UITouch){
        target = gameContentNode.player
        if contains(touch.location(in: parent!)){
            if !active{
                touchBoss = touch
                active = true
                target.aimLine.isHidden = true
            }
        }
    }
    
    func touchMoved(touch : UITouch){
        let pointOfTouch = touch.location(in: self)
        let touchAngle = atan2(pointOfTouch.y, pointOfTouch.x)
        let touchDistance = sqrt(pointOfTouch.x * pointOfTouch.x + pointOfTouch.y * pointOfTouch.y)
        
        if touch == touchBoss{
            if touchDistance < radius{
                smallNode.position = touch.location(in: self)
            }
            else{
                smallNode.position.x = radius * cos(touchAngle)
                smallNode.position.y = radius * sin(touchAngle)
                
            }
            
            if touchDistance < activeRadius{
                target.aimLine.isHidden = true
            }
            else{
                target.aimLine.isHidden = false
                target.aimLine.zRotation = touchAngle
                hasMovedOut = true
            }
        }
    }
    
    func touchEnded(touch : UITouch){
        let pointOfTouch = touch.location(in: self)
        let touchAngle = atan2(pointOfTouch.y, pointOfTouch.x)
        let touchDistance = sqrt(pointOfTouch.x * pointOfTouch.x + pointOfTouch.y * pointOfTouch.y)
        target = gameContentNode.player
        if touchBoss == touch{
            if touchDistance > activeRadius{
                target.aimedShoot(angle: touchAngle)
            }
            else if !hasMovedOut{
                target.shoot()
            }
            smallNode.position.x = 0
            smallNode.position.y = 0
            active = false
            hasMovedOut = false
            target.aimLine.isHidden = true
        }
    }
    
}

