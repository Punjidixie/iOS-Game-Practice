//
//  Level1.swift
//  Practice
//
//  Created by Siraphop Rungtragoolchai on 28/9/19.
//  Copyright © 2019 Siraphop Rungtragoolchai. All rights reserved.
//

import Foundation
import SpriteKit

class Level1: RegularLevel{
    

    
    override init(size: CGSize){
        super.init(size: size)
       
        mapWidth = 2048
        mapHeight = 1536
            
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func didMove(to view: SKView) {
        //Camera setup
        cameraSetup()
        
        self.view?.isMultipleTouchEnabled = true
        self.view!.preferredFramesPerSecond = 120
        self.view!.showsPhysics = false
        
        gameContentNode.anchorPoint = CGPoint(x: 0, y: 0)
        gameContentNode.zPosition = 0
        gameContentNode.position = CGPoint(x: 0, y: 0)
        
        self.physicsWorld.contactDelegate = self;
        self.addChild(gameContentNode)
        
        
        background.size = CGSize(width: 2700, height: 8100)
        background.anchorPoint = CGPoint(x: 0, y: 0)
        background.position = CGPoint(x: 0, y: 0)
        background.zPosition = -1
        gameContentNode.addChild(background)
        

        player.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.3)
        gameContentNode.player = player
        gameContentNode.addChild(player)
        
        addSideWalls();
        
        whiteScreen.size = size
        whiteScreen.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.5)
        whiteScreen.alpha = 0.5
        whiteScreen.zPosition = 0.9
        cameraViewNode.addChild(whiteScreen)
        
        textLabel.fontSize = 100
        textLabel.position = CGPoint(x: self.gameArea.width * 0.5, y: self.gameArea.height * 0.8)
        textLabel.fontColor = SKColor.black
        textLabel.text = "Level 1"
        textLabel.zPosition = 1
        textLabel.isHidden = false
        cameraViewNode.addChild(textLabel)
        
        textLabel2.fontSize = 50
        textLabel2.position = CGPoint(x: self.gameArea.width * 0.5, y: self.gameArea.height * 0.7)
        textLabel2.fontColor = SKColor.black
        textLabel2.text = "Welcome :D"
        textLabel2.zPosition = 1
        textLabel2.isHidden = true
        cameraViewNode.addChild(textLabel2)
        
        textLabel3.fontSize = 50
        textLabel3.position = CGPoint(x: self.gameArea.width * 0.5, y: self.gameArea.height * 0.6)
        textLabel3.fontColor = SKColor.black
        textLabel3.text = "Tap when you're ready..."
        textLabel3.zPosition = 1
        textLabel3.isHidden = true
        cameraViewNode.addChild(textLabel3)
        
        self.addChild(musicNode)
        
        transitionToWaitingForStart()
        
        
    }

    override func update(_ currentTime: TimeInterval){
        if lastUpdateTime == 0 { //first frame
            lastUpdateTime = currentTime
        }
            
        else{
            deltaFrameTime = currentTime - lastUpdateTime
            lastUpdateTime = currentTime
        }
        
        switch currentSceneState{
        case .beginningAnimation:
            break
        case sceneState.waitingForStart:
            break
        case sceneState.inGame:
            player = gameContentNode.player //the scene controls self.player, which might have been removed because of the newly made player
            
            if player.currentPlayerState == Player.playerState.dead {
                transitionToPostGame()

            }
            
            if joystick.active{
                player.movePlayerCheck(deltaFrameTime: self.deltaFrameTime)
            }
            
            gameContentNode.enumerateChildNodes(withName: "Bullet") {
                (bullet, stop) in
                
                (bullet as! Bullet).updateBullet(deltaFrameTime: self.deltaFrameTime)
            }
            
            gameContentNode.enumerateChildNodes(withName: "EnemyBullet") {
                (bullet, stop) in
                (bullet as! EnemyBullet).updateBullet(deltaFrameTime: self.deltaFrameTime)
            }
            
            gameContentNode.enumerateChildNodes(withName: "Enemy") {
                (enemy, stop) in
                (enemy as! Enemy).target = self.player
                (enemy as! Enemy).updateEnemy(deltaFrameTime: self.deltaFrameTime)
            }
            
            gameContentNode.enumerateChildNodes(withName: "Wall") {
                (wall, stop) in
                (wall as! Wall).updateWall(deltaFrameTime: self.deltaFrameTime)
                
            }
            
            gameContentNode.enumerateChildNodes(withName: "Pickable") {
                (pickable, stop) in
                (pickable as! Pickable).updatePickable(deltaFrameTime: self.deltaFrameTime)
            }
            
            
            player.updatePlayer(deltaFrameTime: deltaFrameTime)
            playerInfo.update()
            
            switch currentWave{
            case 1:
                var found = false
                gameContentNode.enumerateChildNodes(withName: "Enemy"){
                    (enemy, stop) in
                    found = true
                }
                if !found{
                    currentWave = 1.5
                    startWave2() //will change to currentWave = 2
                }
                break
            case 2:
                var found = false
                gameContentNode.enumerateChildNodes(withName: "Enemy"){
                    (enemy, stop) in
                    found = true
                }
                if !found{
                    currentWave = 2.5
                    startWave3()
                }
                break
            case 3:
                var found = false
                gameContentNode.enumerateChildNodes(withName: "Enemy"){
                    (enemy, stop) in
                    found = true
                }
                if !found{
                    currentWave = 3.5
                    startWave4()
                }
                break
            case 4:
                var found = false
                gameContentNode.enumerateChildNodes(withName: "Enemy"){
                    (enemy, stop) in
                    found = true
                }
                if !found{
                    currentWave = 4.5
                    transitionToPostGame()
                }
                break
            default:
                break
            }
   
        case .postGame:
            break
            
        case .waitingToLeave:
            break
        case .paused:
            break
        }
        cameraUpdate()
        

    }
    
    override func didSimulatePhysics() { // Physics Bodies are in place
        
        switch currentSceneState{
        case .beginningAnimation:
            break
        case sceneState.waitingForStart:
            break
        case sceneState.inGame:
            if joystick.active{
                player.movePlayer(distance: player.distanceToMove)
            }
            
            gameContentNode.enumerateChildNodes(withName: "Bullet") {
                (bullet, stop) in
                (bullet as! Bullet).moveBullet(distance: (bullet as! Bullet).distanceToMove)
                (bullet as! Bullet).checkCollision()
                
            }
            gameContentNode.enumerateChildNodes(withName: "EnemyBullet") {
                (bullet, stop) in
                (bullet as! EnemyBullet).moveBullet(distance: (bullet as! EnemyBullet).distanceToMove)
                (bullet as! EnemyBullet).checkCollision()
            }
            
            gameContentNode.enumerateChildNodes(withName: "Enemy") {
                (enemy, stop) in
                (enemy as! Enemy).moveEnemy(distance: (enemy as! Enemy).distanceToMove)
            }
            
            gameContentNode.enumerateChildNodes(withName: "Pickable") {
                (pickable, stop) in
                (pickable as! Pickable).checkCollision()
            }
        case sceneState.postGame:
            break
            
        case .waitingToLeave:
            break
        
        case .paused:
            break
        }
    }

    
    override func transitionToWaitingForStart(){
        let wait1Sec = SKAction.wait(forDuration: 1)
        let showLabel2 = SKAction.run{
            self.textLabel2.isHidden = false
        }
        let showLabel3 = SKAction.run{
            self.textLabel3.isHidden = false
        }
        let changeToWaitingForStart = SKAction.run{
            self.currentSceneState = .waitingForStart
        }
        
        run(SKAction.sequence([wait1Sec, showLabel2, wait1Sec, showLabel3, changeToWaitingForStart]))
    }
    
    override func transitionToInGame(){
        currentWave = 0.5
        let wait1sec = SKAction.wait(forDuration: 1)
        let waitHalfSec = SKAction.wait(forDuration: 0.5)
        let showLabel2 = SKAction.run{
            self.textLabel2.isHidden = false
        }
        let showLabel3 = SKAction.run{
            self.textLabel3.isHidden = false
        }
        let hideLabel = SKAction.run{
            self.textLabel.isHidden = true
        }
        let hideLabel2 = SKAction.run{
            self.textLabel2.isHidden = true
        }
        let hideLabel3 = SKAction.run{
            self.textLabel3.isHidden = true
        }
        let hideWhiteScreen = SKAction.run{
            self.whiteScreen.isHidden = true
        }
        let threeSec = SKAction.run{
            self.textLabel3.text = "3"
        }
        let twoSec = SKAction.run{
            self.textLabel3.text = "2"
        }
        let oneSec = SKAction.run{
            self.textLabel3.text = "1"
        }
        let goodluck = SKAction.run{
            self.textLabel3.text = "Wave 1 - Good luck :)"
            self.startWave1()
        }
        let spawnPauseButton = SKAction.run{
            self.pauseButton.position = CGPoint(x: self.gameArea.width * 0.1, y: self.gameArea.height * 0.9)
            self.pauseButton.level = self
            self.cameraViewNode.addChild(self.pauseButton)
        }
        
        let createInterfaces = SKAction.run{
            
            self.currentSceneState = .inGame

            self.joystick.position = CGPoint(x: self.gameArea.width * 0.2, y: self.gameArea.height * 0.2)
            self.joystick.restPosition = self.joystick.position
            self.joystick.gameContentNode = self.gameContentNode
            self.cameraViewNode.addChild(self.joystick)
            
            self.shootButton.position = CGPoint(x: self.gameArea.width * 0.8, y: self.gameArea.height * 0.2)
            self.shootButton.gameContentNode = self.gameContentNode
            self.cameraViewNode.addChild(self.shootButton)
            
            
            /*self.charSelect.gameContentNode = self.gameContentNode
            self.charSelect.position = CGPoint(x: 0, y: self.gameArea.height * 0.8)
            self.cameraViewNode.addChild(self.charSelect)*/
        
            self.playerInfo.gameContentNode = self.gameContentNode
            self.playerInfo.position = CGPoint(x: self.gameArea.width * 0.7, y: self.gameArea.height * 0.8)
            self.cameraViewNode.addChild(self.playerInfo)
        }
        
        run(SKAction.sequence([createInterfaces, hideWhiteScreen, threeSec, wait1sec, twoSec, wait1sec, oneSec, wait1sec, hideLabel, hideLabel2, goodluck, spawnPauseButton, wait1sec, hideLabel3]))
    }
    
    func startWave1(){
        currentWave = 1
        addEnemy(enemy: WeakEnemy(), xPercent: 40, yPercent: 75)
        addEnemy(enemy: WeakEnemy(), xPercent: 60, yPercent: 75)
    }
    
    func startWave2(){
        let wait1Sec = SKAction.wait(forDuration: 1)
        let showLabel2 = SKAction.run{
            self.textLabel2.isHidden = false
            self.textLabel2.text = "Wave 2"
        }
        let hideLabel2 = SKAction.run{
            self.textLabel2.isHidden = true
        }
        let reallyStartWave = SKAction.run{
            self.currentWave = 2
            self.addEnemy(enemy: WeakEnemy(), xPercent: 50, yPercent: 60)
            self.addEnemy(enemy: WeakEnemy(), xPercent: 40, yPercent: 75)
            self.addEnemy(enemy: WeakEnemy(), xPercent: 60, yPercent: 75)
        }
        run(SKAction.sequence([showLabel2, wait1Sec, reallyStartWave, hideLabel2]))
        
    }
    
    func startWave3(){
        let wait1Sec = SKAction.wait(forDuration: 1)
        let showLabel2 = SKAction.run{
            self.textLabel2.isHidden = false
            self.textLabel2.text = "Wave 3"
        }
        let hideLabel2 = SKAction.run{
            self.textLabel2.isHidden = true
        }
        let reallyStartWave = SKAction.run{
            self.currentWave = 3
            self.addEnemy(enemy: WeakEnemy(), xPercent: 50, yPercent: 55)
            self.addEnemy(enemy: WeakEnemy(), xPercent: 40, yPercent: 65)
            self.addEnemy(enemy: WeakEnemy(), xPercent: 60, yPercent: 65)
            self.addEnemy(enemy: WeakEnemy(), xPercent: 50, yPercent: 75)
        }
        run(SKAction.sequence([showLabel2, wait1Sec, reallyStartWave, hideLabel2]))
    }
    
    func startWave4(){
        let wait1Sec = SKAction.wait(forDuration: 1)
        let showLabel2 = SKAction.run{
            self.textLabel2.isHidden = false
            self.textLabel2.text = "Final wave"
        }
        let hideLabel2 = SKAction.run{
            self.textLabel2.isHidden = true
        }
        let reallyStartWave = SKAction.run{
            self.currentWave = 4
            self.addEnemy(enemy: WeakEnemy(), xPercent: 20, yPercent: 65)
            self.addEnemy(enemy: WeakEnemy(), xPercent: 35, yPercent: 75)
            self.addEnemy(enemy: WeakEnemy(), xPercent: 50, yPercent: 65)
            self.addEnemy(enemy: WeakEnemy(), xPercent: 65, yPercent: 75)
            self.addEnemy(enemy: WeakEnemy(), xPercent: 80, yPercent: 65)
        }
        run(SKAction.sequence([showLabel2, wait1Sec, reallyStartWave, hideLabel2]))
    }
    
    override func transitionToPostGame(){
        textLabel.isHidden = false
        whiteScreen.isHidden = false
        currentSceneState = .postGame
        
        if player.currentPlayerState == Player.playerState.dead{
            whiteScreen.texture = SKTexture(imageNamed: "RedSquare")
            whiteScreen.alpha = 0.3
            textLabel.text = "Defeated"
        }
        else{
            textLabel.text = "You won"
        }
        
        joystick.isHidden = true
        playerInfo.isHidden = true
        shootButton.isHidden = true
        
        let wait1Sec = SKAction.wait(forDuration: 1)
        let showLabel2 = SKAction.run{
            self.textLabel2.isHidden = false
            self.textLabel2.text = "Tap to continue"
            self.currentSceneState = .waitingToLeave
        }
        
        run(SKAction.sequence([wait1Sec, showLabel2]))
    }

}

