//
//  Apple.swift
//  Snake
//
//  Created by Anton Gvozdanov on 04/09/2019.
//  Copyright © 2019 Anton Gvozdanov. All rights reserved.
//

import UIKit
import SpriteKit

class Apple: SKShapeNode {
    
    convenience init(position: CGPoint) {
        self.init()
        
        path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 10, height: 10)).cgPath
        
        fillColor = .red
        strokeColor = .red
        
        lineWidth = 5
        
        self.position = position
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: 7, center: CGPoint(x: 5, y: 5))
        self.physicsBody?.categoryBitMask = CollisionCategories.Apple
    }
}
