//
//  BossEyeLevel.swift
//  Practice
//
//  Created by Siraphop Rungtragoolchai on 21/9/19.
//  Copyright © 2019 Siraphop Rungtragoolchai. All rights reserved.
//

import Foundation
import SpriteKit

class BossEyeLevelScene: SKScene, SKPhysicsContactDelegate{
    
    let mapWidth: CGFloat
    let mapHeight: CGFloat
    var player : Player = Trishooter()
    
    let gameContentNode = GameContentNode()
    var playerInfo = PlayerInfo()
    let charSelect = CharacterSelector()
    let shootButton = AimedShootButton()
    
    var joystick = Joystick()
    
    var lastUpdateTime: TimeInterval = 0
    var deltaFrameTime: TimeInterval = 0
    
    
    let cameraNode = SKCameraNode() //just the camera
    let cameraViewNode = SKSpriteNode()//the view that the camera sees, anchor point at the bottom left of the screen
    
    let musicNode = SKAudioNode(fileNamed: "Arabesque1")
    
    let whiteScreen = SKSpriteNode(imageNamed: "WhiteSquare")
    let textLabel = SKLabelNode(fontNamed: "Avenir Next Ultra Light")
    let textLabel2 = SKLabelNode(fontNamed: "Avenir Light")
    
    var spawningCooldownTime : TimeInterval = 5
    var candySpawningCooldownTime : TimeInterval = 7
    let bossEye = BossEye()
    enum sceneState{
        case preGame
        case inGame
        case postGame
    }
    
    var currentSceneState = sceneState.preGame
    
    let gameArea: CGRect
    
    override init(size: CGSize){
        
        var maxAspectRatio: CGFloat = 9.0/16.0
        if Device.IS_IPAD {
            maxAspectRatio = 3.0/4.0
        }
        else if Device.IS_IPHONE && Device.SCREEN_MAX_LENGTH < 812{
            maxAspectRatio = 9.0/16.0
        }
        
        
        let playableHeight = size.width * maxAspectRatio
        let margin = (size.height - playableHeight) / 2
        gameArea = CGRect(x: 0, y: margin, width: size.width, height: playableHeight)
        
        mapWidth = 2048
        mapHeight = 1536
        super.init(size: size)
        
        //let skView = self.view as? SKView
        
        
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
        
        let background = SKSpriteNode(imageNamed: "testbglight")
        background.size = CGSize(width: 2700, height: 8100)
        background.anchorPoint = CGPoint(x: 0, y: 0)
        background.position = CGPoint(x: 0, y: 0)
        background.zPosition = 0
        gameContentNode.addChild(background)
        
        
        let enemy = bossEye
        enemy.position = CGPoint(x : self.size.width * 0.5, y: self.size.height * 1.2)
        gameContentNode.addChild(enemy)
        enemy.target = player
        
        player.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.3)
        gameContentNode.player = player
        gameContentNode.addChild(player)
        
        for i in 0...3{
            let bufferDistance : CGFloat = 768
            let wall = Barrier()
            wall.zRotation = 90 * CGFloat(i) * (.pi/180)
            switch i{
            case 0:
                wall.position.x = size.width / 2
                wall.position.y = size.height + bufferDistance
            
            case 1:
                wall.position.x = -bufferDistance
                wall.position.y = size.height / 2
            
            case 2:
                wall.position.x = size.width / 2
                wall.position.y = -bufferDistance
            case 3:
                wall.position.x = size.width + bufferDistance
                wall.position.y = size.height / 2
            default :
                break
            }
            gameContentNode.addChild(wall)
        
        }
        
        whiteScreen.size = size
        whiteScreen.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.5)
        whiteScreen.alpha = 0.5
        whiteScreen.zPosition = 0.9
        cameraViewNode.addChild(whiteScreen)
        
        textLabel.fontSize = 100
        textLabel.position = CGPoint(x: self.gameArea.width * 0.5, y: self.gameArea.height * 0.6)
        textLabel.fontColor = SKColor.black
        textLabel.text = "Boss Fight"
        textLabel.zPosition = 1
        cameraViewNode.addChild(textLabel)
        
        textLabel2.fontSize = 50
        textLabel2.position = CGPoint(x: self.gameArea.width * 0.5, y: self.gameArea.height * 0.5)
        textLabel2.fontColor = SKColor.black
        textLabel2.text = "Get ready"
        textLabel2.zPosition = 1
        cameraViewNode.addChild(textLabel2)
        
        self.addChild(musicNode)
        
    }
    
    func cameraSetup(){
        cameraNode.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        self.addChild(cameraNode)
        self.camera = cameraNode
        
        cameraViewNode.anchorPoint = CGPoint(x: 0.5, y: 0.5) //set anchor point of the camera view at the bottom left
        
        cameraViewNode.position = CGPoint(x: -self.gameArea.width / 2, y: -self.gameArea.height / 2)
        cameraViewNode.zPosition = 100
        cameraViewNode.size = self.gameArea.size
        cameraNode.addChild(cameraViewNode)
    }
    
    func cameraUpdate(){
        switch currentSceneState{
        case .preGame:
            break
        case .inGame:
            if player.position.y < gameArea.height / 2{
                cameraNode.position.y = gameArea.height/2
            }
            else if player.position.y > mapHeight - gameArea.height / 2{
                cameraNode.position.y = mapHeight - gameArea.height / 2
            }
            else{
                cameraNode.position.y = player.position.y
            }
            
            if player.position.x < gameArea.width / 2{
                cameraNode.position.x = gameArea.width/2
            }
            else if player.position.x > mapWidth - gameArea.width / 2{
                cameraNode.position.x = mapWidth - gameArea.width / 2
            }
            else{
                cameraNode.position.x = player.position.x
            }
        case .postGame:
            break
        }
        
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
        case sceneState.preGame:
            break
        case sceneState.inGame:
            player = gameContentNode.player //the scene controls self.player, which might have been removed because of the newly made player
            
            spawningCooldownTime -= deltaFrameTime
            if spawningCooldownTime < 0{
                spawningCooldownTime = 0
            }
            
            candySpawningCooldownTime -= deltaFrameTime
            if candySpawningCooldownTime < 0{
                candySpawningCooldownTime = 0
            }
            
            if player.currentPlayerState == Player.playerState.dead {
                let sceneToMoveTo = MainMenuScene(size: self.size)
                sceneToMoveTo.scaleMode = self.scaleMode
                let myTransition = SKTransition.fade(withDuration: 0.5)
                self.view!.presentScene(sceneToMoveTo, transition: myTransition)
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
            
            if spawningCooldownTime <= 0{
                summonEnemy()
                spawningCooldownTime = 5
            }
            
            if candySpawningCooldownTime <= 0{
                summonCandy()
                candySpawningCooldownTime = 10
            }
            
        case .postGame:
            break
        }
        cameraUpdate()
        
        
        
        
    }
    
    func summonCandy(){
        var randomX = CGFloat.random(in: size.width * 0.2...size.width * 0.8)
        var randomY = CGFloat.random(in: size.height * 0.3...size.width * 0.6)
        
        let candy = HPCandy()
        candy.position = CGPoint(x: randomX, y: randomY)
        gameContentNode.addChild(candy)
    }
    
    func summonEnemy(){
        let randomNumber = Int.random(in: 0...100)
        let possibilities = 5
        
        var randomX = CGFloat.random(in: size.width * 0.2...size.width * 0.8)
        var randomY = CGFloat.random(in: size.height * 0.5...size.width * 0.7)
        
        while bossEye.contains(CGPoint(x: randomX, y: randomY)){
            randomX = CGFloat.random(in: size.width * 0.2...size.width * 0.8)
            randomY = CGFloat.random(in: size.height * 0.5...size.width * 0.7)
        }
        
        var enemy = Enemy()
        
        if randomNumber < (100*1) / possibilities{
            enemy = WeakEnemy()
        }
        else if randomNumber < (100*2) / possibilities{
            enemy = SuicideEnemy()
        }
        else if randomNumber < (100*3) / possibilities{
            enemy = PoisonEnemy()
        }
        else if randomNumber < (100*4) / possibilities{
            enemy = SpinningEnemy()
        }
        else if randomNumber < (100*5) / possibilities{
            enemy = WalkingEnemy()
        }
        
        enemy.position.x = randomX
        enemy.position.y = randomY
        if enemy is PoisonEnemy || enemy is SuicideEnemy{
            enemy.position.y = self.size.height * 1.1
            
        }
        enemy.target = player
        gameContentNode.addChild(enemy)
        
    }
    
    
    override func didSimulatePhysics() { // Physics Bodies are in place
        
        switch currentSceneState{
        case sceneState.preGame:
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
        }
        
        
        
        
        
    }
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?){
        
        for touch: AnyObject in touches{
            
            let pointOfTouch = touch.location(in: cameraViewNode)
            //let previousPointOfTouch = touch.previousLocation(in: cameraViewNode)
            //let nodeITapped = atPoint(pointOfTouch)
            //let previousNodeITapped = atPoint(previousPointOfTouch)
            
            switch currentSceneState{
                
            case .preGame:
                break
            case .inGame:
                shootButton.touchMoved(touch: touch as! UITouch)
                joystick.touchMoved(touch: touch as! UITouch)
            case .postGame:
                break
            }
        }
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch: AnyObject in touches{
            let pointOfTouch = touch.location(in: cameraViewNode)
            //let nodeITapped = atPoint(pointOfTouch)
            
            switch currentSceneState{
            case .preGame:
                transitionToInGame()
            case .inGame:
                if charSelect.contains(pointOfTouch){
                    charSelect.touchInput(touch: touch as! UITouch)
                }
                    
                else if joystick.active == false && pointOfTouch.x < self.size.width * 0.4 && pointOfTouch.y < gameArea.size.height * 0.4
                {
                    joystick.touchInput(touch: touch as! UITouch)
                    
                }
                else if shootButton.contains(pointOfTouch){
                    shootButton.touchInput(touch: touch as! UITouch)
                }
                /*else if shootButton.locked{
                    gameContentNode.touchInputAimed(touch: touch as! UITouch)
                }*/
            case .postGame:
                break
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for lift: AnyObject in touches{
            let pointOfLift = lift.location(in: cameraViewNode)
            switch currentSceneState{
                
            case .preGame:
                break
            case .inGame:
                joystick.touchEnded(touch: lift as! UITouch)
                shootButton.touchEnded(touch: lift as! UITouch)
            case .postGame:
                break
            }
        }
    }
    
    func transitionToInGame(){
        let wait1sec = SKAction.wait(forDuration: 1)
        let threeSec = SKAction.run{
            self.textLabel2.text = "3"
        }
        let twoSec = SKAction.run{
            self.textLabel2.text = "2"
        }
        let oneSec = SKAction.run{
            self.textLabel2.text = "1"
        }
        let goodluck = SKAction.run{
            self.textLabel.removeFromParent()
            self.textLabel2.text = "Good luck :)"
        }
        let label2Remove = SKAction.run{
            self.textLabel2.removeFromParent()
        }
        let createInterfaces = SKAction.run{
            
            self.currentSceneState = .inGame
            self.whiteScreen.removeFromParent()
            
            self.joystick.position = CGPoint(x: self.gameArea.width * 0.2, y: self.gameArea.height * 0.2)
            self.joystick.restPosition = self.joystick.position
            self.joystick.gameContentNode = self.gameContentNode
            self.cameraViewNode.addChild(self.joystick)
            
            self.shootButton.position = CGPoint(x: self.gameArea.width * 0.8, y: self.gameArea.height * 0.2)
            self.shootButton.gameContentNode = self.gameContentNode
            self.cameraViewNode.addChild(self.shootButton)

            self.charSelect.gameContentNode = self.gameContentNode
            self.charSelect.position = CGPoint(x: 0, y: self.gameArea.height * 0.8)
            self.cameraViewNode.addChild(self.charSelect)
        
            self.playerInfo.gameContentNode = self.gameContentNode
            self.playerInfo.position = CGPoint(x: self.gameArea.width * 0.7, y: self.gameArea.height * 0.8)
            self.cameraViewNode.addChild(self.playerInfo)
        }
        
        run(SKAction.sequence([threeSec, wait1sec, twoSec, wait1sec, oneSec, wait1sec, createInterfaces, goodluck, wait1sec, label2Remove]))
    }
    
    
    
    
    
}
