//
//  SnakeBodyPart.swift
//  Snake
//
//  Created by Anton Gvozdanov on 04/09/2019.
//  Copyright © 2019 Anton Gvozdanov. All rights reserved.
//

import UIKit
import SpriteKit

class SnakeBodyPart: SKShapeNode {
    
    init(atPoint point: CGPoint) {
        super.init()
        
        path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 10, height: 10)).cgPath
        
        fillColor = .green
        strokeColor = .green
        
        lineWidth = 5
        
        self.position = point
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: 3, center: CGPoint(x: 5, y: 5))
        self.physicsBody?.isDynamic = true
        self.physicsBody?.categoryBitMask = CollisionCategories.Snake
        self.physicsBody?.contactTestBitMask = CollisionCategories.EdgeBody | CollisionCategories.Apple
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
