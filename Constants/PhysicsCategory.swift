//
//  PhysicsCategory.swift
//  Practice
//
//  Created by Siraphop Rungtragoolchai on 28/8/19.
//  Copyright © 2019 Siraphop Rungtragoolchai. All rights reserved.
//

import Foundation

class PhysicsCategory{
    static let None : UInt32 = 0
    static let Player : UInt32 = 0b1
    static let Bullet : UInt32 = 0b10
    static let PlayerPhantom : UInt32 = 0b11
    static let Wall : UInt32 = 0b100
    static let Enemy : UInt32 = 0b101
    static let EnemyBullet : UInt32 = 0b110
    static let Pickable : UInt32 = 0b111
    
}
