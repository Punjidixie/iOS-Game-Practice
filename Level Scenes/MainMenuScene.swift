//
//  MainMenuScene.swift
//  Practice
//
//  Created by Siraphop Rungtragoolchai on 21/6/19.
//  Copyright © 2019 Siraphop Rungtragoolchai. All rights reserved.
//

import SpriteKit

class MainMenuScene: SKScene{
    
    
    let gameName = SKLabelNode(fontNamed: "Avenir Light")
    let startButton = SKLabelNode(fontNamed: "Avenir Light")
    
    enum sceneState{
        case beginning
        case during
        case ending
    }
    
    var currentSceneState = sceneState.beginning
    
    override func didMove(to view: SKView) {
        
        gameName.text = "Project Lampy"
        gameName.fontSize = 100
        gameName.fontColor = SKColor.white
        gameName.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 1.2)
        gameName.zPosition = 1
        self.addChild(gameName)
        
        startButton.text = "Tap to start"
        startButton.fontSize = 50
        startButton.fontColor = SKColor.white
        startButton.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 1.2)
        startButton.zPosition = 1
        self.addChild(startButton)
        
        let gameNameMoveAction = SKAction.moveTo(y: self.size.height * 0.5, duration: 0.4)
        
        let waitAction = SKAction.wait(forDuration: 1)
        let startButtonMoveAction = SKAction.moveTo(y: self.size.height * 0.4, duration: 0.4)
        let scaleUp = SKAction.scale(to: 1.1, duration: 0.25)
        let scaleDown = SKAction.scale(to: 0.9, duration: 0.25)
        gameName.run(gameNameMoveAction)
        let sequence1 = SKAction.sequence([waitAction, startButtonMoveAction])
        let sequence2 = SKAction.sequence([scaleDown, scaleUp])
        let sequence3 = SKAction.repeatForever(sequence2)
        let changeToDuringAction = SKAction.run{
            self.currentSceneState = sceneState.during
        }
        let superSequence = SKAction.sequence([sequence1, changeToDuringAction, sequence3])
        startButton.run(superSequence)
        
    }
    
    
    
    func changeScene(){
        let sceneToMoveTo = BossEyeLevelScene(size: self.size)
        sceneToMoveTo.scaleMode = self.scaleMode
        let myTransition = SKTransition.fade(withDuration: 0.5)
        self.view!.presentScene(sceneToMoveTo, transition: myTransition)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if currentSceneState == sceneState.during{
            changeScene()
        }
        
        
    }
    
    
}
