//
//  LevelWaves.swift
//  Practice
//
//  Created by Siraphop Rungtragoolchai on 30/9/19.
//  Copyright © 2019 Siraphop Rungtragoolchai. All rights reserved.
//

import Foundation
import SpriteKit

class RegularLevel: SKScene, SKPhysicsContactDelegate{
    
    var mapWidth: CGFloat
    var mapHeight: CGFloat
    var player : Player = Trishooter()
    var background = SKSpriteNode(imageNamed: "testbglight")
    
    let gameContentNode = GameContentNode()
    var playerInfo = PlayerInfo()
    //let charSelect = CharacterSelector()
    var shootButton = AimedShootButton()
    let pauseButton = PauseButton()
    let pauseWindow = PauseWindow()
    
    var joystick = Joystick()
    
    var lastUpdateTime: TimeInterval = 0
    var deltaFrameTime: TimeInterval = 0
    
    
    let cameraNode = SKCameraNode() //just the camera
    let cameraViewNode = SKSpriteNode()//the view that the camera sees, anchor point at the bottom left of the screen
    
    let musicNode = SKAudioNode(fileNamed: "Arabesque1")
    
    let whiteScreen = SKSpriteNode(imageNamed: "WhiteSquare")
    let textLabel = SKLabelNode(fontNamed: "Avenir Light")
    let textLabel2 = SKLabelNode(fontNamed: "Avenir Light")
    let textLabel3 = SKLabelNode(fontNamed: "Avenir Light")
    
    var spawningCooldownTime : TimeInterval = 5
    var candySpawningCooldownTime : TimeInterval = 7
    
    enum sceneState{
        case beginningAnimation
        case waitingForStart
        case inGame
        case postGame
        case waitingToLeave
        case paused
    }
    
    var currentSceneState = sceneState.beginningAnimation
    var startingGame = false
    var currentWave : CGFloat = 0
    
    var gameArea: CGRect
    
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
        case .beginningAnimation:
            break
        case .waitingForStart:
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
        
        case .waitingToLeave:
            break
        case .paused:
            break
        }
        
        
    }
    
    
    override func update(_ currentTime: TimeInterval){
        

    }
    
    override func didSimulatePhysics() { // Physics Bodies are in place
        
        
    }
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?){
        
        for touch: AnyObject in touches{
            
            let pointOfTouch = touch.location(in: cameraViewNode)
            //let previousPointOfTouch = touch.previousLocation(in: cameraViewNode)
            //let nodeITapped = atPoint(pointOfTouch)
            //let previousNodeITapped = atPoint(previousPointOfTouch)
            
            switch currentSceneState{
                
            case .beginningAnimation:
                break
            case .waitingForStart:
                break
            case .inGame:
                shootButton.touchMoved(touch: touch as! UITouch)
                joystick.touchMoved(touch: touch as! UITouch)
                pauseButton.touchMoved(touch: touch as! UITouch)
            case .postGame:
                break
                
            case .waitingToLeave:
                break
            case .paused:
                pauseWindow.touchMoved(touch: touch as! UITouch)
            }
        }
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch: AnyObject in touches{
            let pointOfTouch = touch.location(in: cameraViewNode)
            //let nodeITapped = atPoint(pointOfTouch)
            
            switch currentSceneState{
            case .beginningAnimation:
                break
            case .waitingForStart:
                if !startingGame{
                    startingGame = true
                    transitionToInGame()
                }
            case .inGame:
                /*if charSelect.contains(pointOfTouch){
                    charSelect.touchInput(touch: touch as! UITouch)
                }*/
                    
                if joystick.active == false && pointOfTouch.x < self.size.width * 0.4 && pointOfTouch.y < gameArea.size.height * 0.4
                {
                    joystick.touchInput(touch: touch as! UITouch)
                    
                }
                else if shootButton.contains(pointOfTouch){
                    shootButton.touchInput(touch: touch as! UITouch)
                }
                else if pauseButton.contains(pointOfTouch){
                    pauseButton.touchInput(touch: touch as! UITouch)
                }
                /*else if shootButton.locked{
                    gameContentNode.touchInputAimed(touch: touch as! UITouch)
                }*/
            case .postGame:
                break
               
            case .waitingToLeave:
                leaveGame()
                
            case .paused:
                pauseWindow.touchInput(touch: touch as! UITouch)
            }
            
            
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for lift: AnyObject in touches{
            let pointOfLift = lift.location(in: cameraViewNode)
            switch currentSceneState{
                
            case .beginningAnimation:
                break
            case .waitingForStart:
                break
            case .inGame:
                joystick.touchEnded(touch: lift as! UITouch)
                shootButton.touchEnded(touch: lift as! UITouch)
                pauseButton.touchEnded(touch: lift as! UITouch)
                
            case .postGame:
                break
                
            case .waitingToLeave:
                break
            case .paused:
                pauseWindow.touchEnded(touch: lift as! UITouch)
                break
            }
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchesEnded(touches, with: event)
    }
    
    func transitionToWaitingForStart(){
       
    }
    
    func transitionToInGame(){
        
    }

    func transitionToPostGame(){
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
        pauseButton.isHidden = true
        
        let wait1Sec = SKAction.wait(forDuration: 1)
        let showLabel2 = SKAction.run{
            self.textLabel2.isHidden = false
            self.textLabel2.text = "Tap to continue"
            self.currentSceneState = .waitingToLeave
        }
        
        run(SKAction.sequence([wait1Sec, showLabel2]))
    }
    
    func pauseGame(){
        pauseButton.isHidden = true
        
        pauseWindow.position = CGPoint(x: gameArea.size.width / 2, y: gameArea.size.height / 2)
        pauseWindow.level = self
        cameraViewNode.addChild(pauseWindow)
        
        whiteScreen.isHidden = false
        currentSceneState = .paused
        self.view?.isMultipleTouchEnabled = false
    }
    
    func resumeGame(){
        pauseButton.isHidden = false
        
        joystick.removeFromParent()
        joystick = Joystick()
        joystick.position = CGPoint(x: gameArea.width * 0.2, y: gameArea.height * 0.2)
        joystick.restPosition = joystick.position
        joystick.gameContentNode = gameContentNode
        cameraViewNode.addChild(joystick)
        
        shootButton.removeFromParent()
        shootButton = AimedShootButton()
        shootButton.position = CGPoint(x: gameArea.width * 0.8, y: gameArea.height * 0.2)
        shootButton.gameContentNode = gameContentNode
        cameraViewNode.addChild(shootButton)
        
        pauseWindow.removeFromParent()
        whiteScreen.isHidden = true
        currentSceneState = .inGame
        self.view?.isMultipleTouchEnabled = true
    }
    
    func leaveGame(){
        let sceneToMoveTo = MainMenuScene(size: self.size)
        sceneToMoveTo.scaleMode = self.scaleMode
        let myTransition = SKTransition.fade(withDuration: 0.5)
        self.view!.presentScene(sceneToMoveTo, transition: myTransition)
    }
    func addSideWalls(){
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
    }
    
    func addEnemy(enemy: Enemy, x : CGFloat, y: CGFloat){
        gameContentNode.addChild(enemy)
        enemy.position = CGPoint(x: x, y: y)
        enemy.target = player
    }
    
    func addEnemy(enemy: Enemy, xPercent: CGFloat, yPercent: CGFloat){
        gameContentNode.addChild(enemy)
        enemy.position = CGPoint(x: mapWidth * (xPercent / 100), y: mapHeight * (yPercent / 100))
        enemy.target = player
    
    }
    
    func addEnemy(enemy: Enemy, x : CGFloat, y: CGFloat, maxHp : CGFloat){
        enemy.initMaxHp(maxHp: maxHp)
        gameContentNode.addChild(enemy)
        enemy.position = CGPoint(x: x, y: y)
        enemy.target = player
    }
    
    func addEnemy(enemy: Enemy, xPercent: CGFloat, yPercent: CGFloat, maxHp : CGFloat){
        enemy.initMaxHp(maxHp: maxHp)
        gameContentNode.addChild(enemy)
        enemy.position = CGPoint(x: mapWidth * (xPercent / 100), y: mapHeight * (yPercent / 100))
        enemy.target = player
    }
    
    func addCandy(hpCandy: HPCandy, xPercent : CGFloat, yPercent : CGFloat, heal : CGFloat){
        hpCandy.heal = heal
        hpCandy.position = CGPoint(x: mapWidth * (xPercent / 100), y: mapHeight * (yPercent / 100))
        gameContentNode.addChild(hpCandy)
    }
    
}


