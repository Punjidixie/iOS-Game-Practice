//
//  TestLevelScene.swift
//  Practice
//
//  Created by Siraphop Rungtragoolchai on 21/6/19.
//  Copyright © 2019 Siraphop Rungtragoolchai. All rights reserved.
//

import Foundation
import SpriteKit

class TestLevelScene: SKScene, SKPhysicsContactDelegate{
    
    let mapWidth: CGFloat
    let mapHeight: CGFloat
    var player : Player = Warper()

    let gameContentNode = GameContentNode()
    var playerInfo = PlayerInfo()
    let charSelect = CharacterSelector()
    let shootButton = ShootButton()
    
    var joystickActive = false
    let joystick = SKSpriteNode(imageNamed: "Joystick Base")
    var joystickBoss = UITouch()
    let joystickSmall = SKSpriteNode(imageNamed: "Joystick Light")
    
    let joystickSmallRadius = CGFloat(75)
    let joystickRadius = CGFloat(150)
    
    var lastUpdateTime: TimeInterval = 0
    var deltaFrameTime: TimeInterval = 0
    
    
    let cameraNode = SKCameraNode() //just the camera
    let cameraViewNode = SKSpriteNode()//the view that the camera sees, anchor point at the bottom left of the screen
    

    let musicNode = SKAudioNode(fileNamed: "Arabesque1")
    
    
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
        
        let enemy = WalkingEnemy()
        enemy.position = CGPoint(x : 1000, y: 1000)
        gameContentNode.addChild(enemy)
        enemy.target = player
        
        player.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.3)
        gameContentNode.player = player
        gameContentNode.addChild(player)
        
        let wall = Barrier()
        wall.position = CGPoint(x : 1500, y: 1500)
        gameContentNode.addChild(wall)
        
        
        joystick.size = CGSize(width: joystickRadius * 2, height: joystickRadius * 2)
        joystick.position = CGPoint(x: self.gameArea.width * 0.2, y: self.gameArea.height * 0.2)
        joystick.zPosition = 0
        joystick.alpha = 0.7
        cameraViewNode.addChild(joystick)
        
        joystickSmall.size = CGSize(width: joystickSmallRadius * 2, height: joystickSmallRadius * 2)
        joystickSmall.position = joystick.position
        joystickSmall.zPosition = 1
        joystickSmall.alpha = 0.7
        cameraViewNode.addChild(joystickSmall)
        
        
        shootButton.position = CGPoint(x: self.gameArea.width * 0.8, y: self.gameArea.height * 0.2)
        shootButton.gameContentNode = gameContentNode
        cameraViewNode.addChild(shootButton)
        
        /*changeButton.size = CGSize(width: joystickSmallRadius * 2, height: joystickSmallRadius * 2)
        changeButton.position = CGPoint(x: self.gameArea.width * 0.2, y: self.gameArea.height * 0.8)
        changeButton.zPosition = 4
        changeButton.alpha = 0.7
        cameraViewNode.addChild(changeButton)*/
        
        charSelect.gameContentNode = gameContentNode
        charSelect.position = CGPoint(x: 0, y: self.gameArea.height * 0.8)
        cameraViewNode.addChild(charSelect)
        
        playerInfo.gameContentNode = gameContentNode
        playerInfo.position = CGPoint(x: self.gameArea.width * 0.7, y: self.gameArea.height * 0.8)
        cameraViewNode.addChild(playerInfo)
        
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
    }
    
    
    override func update(_ currentTime: TimeInterval){
        player = gameContentNode.player //the scene controls self.player, which might have been removed because of the newly made player
        
        if player.currentPlayerState == Player.playerState.dead {
            let sceneToMoveTo = MainMenuScene(size: self.size)
            sceneToMoveTo.scaleMode = self.scaleMode
            let myTransition = SKTransition.fade(withDuration: 0.5)
            self.view!.presentScene(sceneToMoveTo, transition: myTransition)
        }
        
        if lastUpdateTime == 0 { //first frame
            lastUpdateTime = currentTime
        }
        
        else{
            deltaFrameTime = currentTime - lastUpdateTime
            lastUpdateTime = currentTime
        }
        
        if joystickActive{
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
        
        cameraUpdate()
        player.updatePlayer(deltaFrameTime: deltaFrameTime)
        playerInfo.update()
        
        
        
    }
    
   
    
    func didBegin(_ contact: SKPhysicsContact) {
       // player < bullet < player phantom < wall < enemy < enemy bullet
       /* var body1 = SKPhysicsBody()
        var body2 = SKPhysicsBody()
        
        if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask){
            body1 = contact.bodyA
            body2 = contact.bodyB
        }
        else{
            body1 = contact.bodyB
            body2 = contact.bodyA
        }
        
        let node1 = body1.node
        let node2 = body2.node
        if (body1.categoryBitMask == PhysicsCategory.Bullet && body2.categoryBitMask == PhysicsCategory.Wall){
            (body2.node as! Wall).hitBy(something: body1.node as! Bullet)
            (body1.node as! Bullet).hits(something: body2.node as! Wall)
            
        }
        
        if (body1.categoryBitMask == PhysicsCategory.Player && body2.categoryBitMask == PhysicsCategory.EnemyBullet){
            (body1.node as! Player).hitBy(something: body2.node as! EnemyBullet)
            (body2.node as! EnemyBullet).hits(something: body1.node as! Player)
        }
        
        if (body1.categoryBitMask == PhysicsCategory.Bullet && body2.categoryBitMask == PhysicsCategory.Enemy){
            (body2.node as! Enemy).hitBy(something: body1.node as! Bullet)
            (body1.node as! Bullet).hits(something: body2.node as! Enemy)
            
            
        } */
 
    }
 
    
    func didEnd(_ contact: SKPhysicsContact) {
        /*var body1 = SKPhysicsBody() //player
        var body2 = SKPhysicsBody() //wall
        
        if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask){
            body1 = contact.bodyA
            body2 = contact.bodyB
        }
        else{
            body1 = contact.bodyB
            body2 = contact.bodyA
        }
        if (body1.categoryBitMask == PhysicsCategory.PlayerPhantom && body2.categoryBitMask == PhysicsCategory.Wall){
            
            if body1.node! == player.playerPhantomX{
                player.canMoveX = true
            }
            if body1.node! == player.playerPhantomY{
                player.canMoveY = true
            }
        }*/
        
    }
    
    override func didSimulatePhysics() { // Physics Bodies are in place
        
        if joystickActive{
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
        
        
        
    }
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?){
        
        for touch: AnyObject in touches{
            
            let pointOfTouch = touch.location(in: cameraViewNode)
            //let previousPointOfTouch = touch.previousLocation(in: cameraViewNode)
            //let nodeITapped = atPoint(pointOfTouch)
            //let previousNodeITapped = atPoint(previousPointOfTouch)
            
            shootButton.touchMoved(touch: touch as! UITouch)
            
            if joystickActive == true && touch as! NSObject == joystickBoss{
                let playerAngle = atan2(pointOfTouch.y - joystick.position.y, pointOfTouch.x - joystick.position.x)
                
                player.playerBody.zRotation = playerAngle
                
                let touchDistance = sqrt((pointOfTouch.x - joystick.position.x) * (pointOfTouch.x - joystick.position.x) + (pointOfTouch.y - joystick.position.y) * (pointOfTouch.y - joystick.position.y))
                
                if touchDistance <= joystickRadius{
                    joystickSmall.position = pointOfTouch
                }
                else{
                    joystickSmall.position.x = joystick.position.x + joystickRadius * cos(playerAngle)
                    joystickSmall.position.y = joystick.position.y + joystickRadius * sin(playerAngle)
                }
            }
        }
    }

    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch: AnyObject in touches{
            
            let pointOfTouch = touch.location(in: cameraViewNode)
            //let nodeITapped = atPoint(pointOfTouch)
            
            if charSelect.contains(pointOfTouch){
                charSelect.touchInput(touch: touch as! UITouch)
            }
            
            else if joystickActive == false && pointOfTouch.x < self.size.width * 0.4 && pointOfTouch.y < gameArea.size.height * 0.4
            {
                joystick.position = pointOfTouch
                joystickSmall.position = joystick.position
                joystickActive = true
                joystickBoss = touch as! UITouch
                
            }
            else if shootButton.contains(pointOfTouch){
                shootButton.touchInput(touch: touch as! UITouch)
            }
            else if shootButton.locked{
                gameContentNode.touchInputAimed(touch: touch as! UITouch)
            }
            
            
            
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for lift: AnyObject in touches{
            
            let pointOfLift = lift.location(in: cameraViewNode)
            
            if joystickActive == true && lift as! NSObject == joystickBoss{
                joystickActive = false
                joystick.position = CGPoint(x: self.gameArea.width * 0.2, y: self.gameArea.height * 0.2)
                joystickSmall.position = joystick.position
            }
            
            
            shootButton.touchEnded(touch: lift as! UITouch)
            
            
            
        }
    }

    
    
    
    
    
}
