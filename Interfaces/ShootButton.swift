//
//  ShootButton.swift
//  Practice
//
//  Created by Siraphop Rungtragoolchai on 14/9/19.
//  Copyright © 2019 Siraphop Rungtragoolchai. All rights reserved.
//

import Foundation
import SpriteKit

class ShootButton: SKSpriteNode{
    
    
    var gameContentNode : GameContentNode!
    var target : Player!
    var touchBoss = UITouch()
    
    let lockerNode = SKSpriteNode(imageNamed: "Joystick Light")
    let radius : CGFloat = 75
    
    var active = false
    var locked = false
    
    enum buttonState{
        case inactive
        case active
    }
    
    
    init(){
        super.init(texture: SKTexture(imageNamed: "Joystick Base"), color: UIColor(), size: CGSize(width: 0, height: 0))
        size = CGSize(width: 150, height: 150)
        alpha = 0.7
        
        lockerNode.size = size
        lockerNode.zPosition = 1
        addChild(lockerNode)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func touchInput(touch : UITouch){
        if contains(touch.location(in: parent!)){
            touchBoss = touch
            lockerNode.position = CGPoint(x: 0, y: 0)
            if locked{
               lockerNode.texture = SKTexture(imageNamed: "Blank")
            }
            else{
               lockerNode.texture = SKTexture(imageNamed: "Joystick Light")
            }
            
        }
    }
    
    func touchMoved(touch : UITouch){
        let pointOfTouch = touch.location(in: self)
        let touchAngle = atan2(pointOfTouch.y, pointOfTouch.x)
        let touchDistance = sqrt(pointOfTouch.x * pointOfTouch.x + pointOfTouch.y * pointOfTouch.y)
        
        if touch == touchBoss{
            if touchDistance < radius{
                lockerNode.position = touch.location(in: self)
            }
            else{
                lockerNode.position.x = radius * cos(touchAngle)
                lockerNode.position.y = radius * sin(touchAngle)
            }
        }
    }
    
    func touchEnded(touch : UITouch){
        let pointOfTouch = touch.location(in: self)
        let touchDistance = sqrt(pointOfTouch.x * pointOfTouch.x + pointOfTouch.y * pointOfTouch.y)
        target = gameContentNode.player
        if touchBoss == touch{
            if touchDistance < radius && locked == false{ //normal shooting
                target.shoot()
                lockerNode.texture = SKTexture(imageNamed: "Blank")
            }
            else if locked == true{ //remove lock
                locked = false
                lockerNode.texture = SKTexture(imageNamed: "Blank")
            }
            else { //lock
                locked = true
            }
            
        }
    }
    
}
