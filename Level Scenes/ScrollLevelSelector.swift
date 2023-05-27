//
//  ScrollLevelSelector.swift
//  Practice
//
//  Created by Siraphop Rungtragoolchai on 29/9/19.
//  Copyright © 2019 Siraphop Rungtragoolchai. All rights reserved.
//

import SpriteKit

class ScrollLevelSelector: SKScene{
    
    
    let gameName = SKLabelNode(fontNamed: "Avenir Light")
    let startButton = SKLabelNode(fontNamed: "Avenir Light")
    var spriteArray : [SKSpriteNode] = []
    var closestIndex = 0
    var currentIndex : CGFloat = 0
    
    var lastUpdateTime: TimeInterval = 0
    var deltaFrameTime: TimeInterval = 0
    
    var manualScrollingSpeed : CGFloat = 0
    var manualScrollingAccerelation : CGFloat = 2000
    var minScrollingSpeed : CGFloat = 100
    
    var manualScrolling = false
    
    
    
    enum sceneState{
        case beginning
        case during
        case ending
    }
    
    enum scrollingMode{
        case auto
        case manual
    }
    
    var currentSceneState = sceneState.beginning
    
    override init(size: CGSize) {
        super.init(size: size)
        
        
        spriteArray.append(SKSpriteNode(imageNamed: "Scallion of Peace HD"))
        spriteArray.append(SKSpriteNode(imageNamed: "Catcher"))
        spriteArray.append(SKSpriteNode(imageNamed: "Lampy"))
        spriteArray.append(SKSpriteNode(imageNamed: "Leonardo"))
        
        for i in 0...3{
            let sprite = spriteArray[i]
            sprite.position.y = (size.height / 2) - size.height * CGFloat(i)
            sprite.position.x = size.width * 0.6
            sprite.size = CGSize(width: 1700, height: 1700)
            addChild(sprite)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        
        self.view?.isMultipleTouchEnabled = false
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        if lastUpdateTime == 0 { //first frame
            lastUpdateTime = currentTime
        }
                   
        else{
            deltaFrameTime = currentTime - lastUpdateTime
            lastUpdateTime = currentTime
        }
        
        
        if !manualScrolling{
            var willScroll = true
            currentIndex = (spriteArray[0].position.y - (size.height / 2)) / size.height
            if manualScrollingSpeed > 0{ //going up (scrolling down)
                manualScrollingSpeed += -manualScrollingAccerelation * CGFloat(deltaFrameTime)
                closestIndex = Int(ceil((spriteArray[0].position.y - (size.height / 2)) / size.height))
            }
            else if manualScrollingSpeed < 0{ //going down (scrolling up)
                manualScrollingSpeed += manualScrollingAccerelation * CGFloat(deltaFrameTime)
                closestIndex = Int(floor((spriteArray[0].position.y - (size.height / 2)) / size.height))
            }
            else{
                
            }
            if abs(manualScrollingSpeed) < minScrollingSpeed{
                if manualScrollingSpeed > 0{ //going up (scrolling down)
                    manualScrollingSpeed = minScrollingSpeed
                }
                else if manualScrollingSpeed < 0{ //going down (scrolling up)
                    manualScrollingSpeed = -minScrollingSpeed
                }
            }
            
            for i in 0...3{
                if manualScrollingSpeed > 0{ //going up (scrolling down)
                    
                }
                else if manualScrollingSpeed < 0{ //going down (scrolling up)
                    
                }
                if willScroll{
                    spriteArray[i].position.y += manualScrollingSpeed * CGFloat(deltaFrameTime)
                }
            }
        }
    }
    
    
    
    
    func changeScene(){
        let sceneToMoveTo = Level2(size: self.size)
        sceneToMoveTo.scaleMode = self.scaleMode
        let myTransition = SKTransition.fade(withDuration: 0.5)
        self.view!.presentScene(sceneToMoveTo, transition: myTransition)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        manualScrolling = true
        for touch : AnyObject in touches{
            
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch : AnyObject in touches{
            let pointOfTouch = touch.location(in: self)
            let previousPointOfTouch = touch.previousLocation(in: self)
            
            
            if spriteArray[0].position.y > 0{
                for sprite in spriteArray{
                    sprite.position.y += pointOfTouch.y - previousPointOfTouch.y
                    manualScrollingSpeed = (pointOfTouch.y - previousPointOfTouch.y) / CGFloat(deltaFrameTime)
                }
            }
            else if spriteArray[0].position.y <= 0{
                for sprite in spriteArray{
                    if (pointOfTouch.y - previousPointOfTouch.y) > 0{
                        sprite.position.y += pointOfTouch.y - previousPointOfTouch.y
                        manualScrollingSpeed = (pointOfTouch.y - previousPointOfTouch.y) / CGFloat(deltaFrameTime)
                    }
                    else{
                        manualScrollingSpeed = 0
                    }
                }
               
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        manualScrolling = false
    }
    
    
}
