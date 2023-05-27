//
//  GameContentNode.swift
//  Practice
//
//  Created by Siraphop Rungtragoolchai on 9/9/19.
//  Copyright © 2019 Siraphop Rungtragoolchai. All rights reserved.
//

import Foundation
import SpriteKit

class GameContentNode: SKSpriteNode, SKPhysicsContactDelegate{
    
    var player : Player!
    
    init(){
        
        let texture = SKTexture(imageNamed: "Blank")
        super.init(texture: texture, color: UIColor(), size: texture.size())
        anchorPoint = CGPoint(x: 0, y: 0)
        zPosition = 0
        position = CGPoint(x: 0, y: 0)
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
    func touchInputAimed(touch : UITouch){
        let pointOfTouch = touch.location(in: self)
        let aimedAngle = atan2(pointOfTouch.y - player.position.y, pointOfTouch.x - player.position.x)
        player.aimedShoot(angle: aimedAngle)
    }
    
    
}
