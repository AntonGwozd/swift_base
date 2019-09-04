//
//  SnakeHead.swift
//  Snake
//
//  Created by Anton Gvozdanov on 04/09/2019.
//  Copyright © 2019 Anton Gvozdanov. All rights reserved.
//

import Foundation

import UIKit
import SpriteKit

class SnakeHead: SnakeBodyPart {
    override init(atPoint point: CGPoint) {
        super.init(atPoint: point)
        
        self.physicsBody?.categoryBitMask = CollisionCategories.SnakeHead
        self.physicsBody?.contactTestBitMask = CollisionCategories.EdgeBody | CollisionCategories.Apple | CollisionCategories.Snake | CollisionCategories.BadApple
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
