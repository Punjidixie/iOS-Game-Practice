//
//  Joystick.swift
//  Practice
//
//  Created by Siraphop Rungtragoolchai on 24/9/19.
//  Copyright © 2019 Siraphop Rungtragoolchai. All rights reserved.
//

import Foundation
import SpriteKit

class Joystick: SKSpriteNode{
    
    
    var gameContentNode : GameContentNode!
    var target : Player!
    var touchBoss = UITouch()
    
    let controllerNode = SKSpriteNode(imageNamed: "Joystick Light")
    let radius : CGFloat = 150
    let controllerNodeRadius : CGFloat = 75
    
    var active = false
    var restPosition = CGPoint(x: 0, y: 0)
    
    
    init(){
        super.init(texture: SKTexture(imageNamed: "Joystick Base"), color: UIColor(), size: CGSize(width: 0, height: 0))
        size = CGSize(width: radius * 2, height: radius * 2)
        alpha = 0.7
        
        controllerNode.size = CGSize(width: controllerNodeRadius * 2, height: controllerNodeRadius * 2)
        controllerNode.position = CGPoint(x: 0, y: 0)
        controllerNode.zPosition = 1
        addChild(controllerNode)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func touchInput(touch : UITouch){
        let touchLocation = touch.location(in: parent!)
        if !active{
            touchBoss = touch
            position = touchLocation
            active = true
        }
        
        
    }
    
    func touchMoved(touch : UITouch){
        let pointOfTouch = touch.location(in: self)
        let touchAngle = atan2(pointOfTouch.y, pointOfTouch.x)
        let touchDistance = sqrt(pointOfTouch.x * pointOfTouch.x + pointOfTouch.y * pointOfTouch.y)
        target = gameContentNode.player
        if touch == touchBoss{
            if touchDistance < radius{
                controllerNode.position = touch.location(in: self)
            }
            else{
                controllerNode.position.x = radius * cos(touchAngle)
                controllerNode.position.y = radius * sin(touchAngle)
            }
            target.playerBody.zRotation = touchAngle
        }
    }
    
    func touchEnded(touch : UITouch){
        let pointOfTouch = touch.location(in: self)
        let touchDistance = sqrt(pointOfTouch.x * pointOfTouch.x + pointOfTouch.y * pointOfTouch.y)
        target = gameContentNode.player
        if touchBoss == touch{
            active = false
            position = restPosition
            controllerNode.position = CGPoint(x: 0, y: 0)
        }
    }
    
}
