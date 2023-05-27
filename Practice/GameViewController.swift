//
//  GameViewController.swift
//  Practice
//
//  Created by Siraphop Rungtragoolchai on 21/6/19.
//  Copyright © 2019 Siraphop Rungtragoolchai. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scene = MainMenuScene(size: CGSize(width: 2048, height: 1536))
        let skview = self.view as! SKView
            // Load the SKScene from 'GameScene.sks'
        
        // Set the scale mode to scale to fit the window
        scene.scaleMode = .aspectFill
                
        // Present the scene
        skview.presentScene(scene)
            
            
        skview.ignoresSiblingOrder = true
            
        skview.showsFPS = true
        skview.showsNodeCount = true
        
        skview.isMultipleTouchEnabled = true;
        
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
