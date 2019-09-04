//
//  Snake.swift
//  Snake
//
//  Created by Anton Gvozdanov on 04/09/2019.
//  Copyright © 2019 Anton Gvozdanov. All rights reserved.
//

import UIKit
import SpriteKit

class Snake: SKShapeNode {
    
    let moveSpeed: CGFloat = 125.0
    
    var angle: CGFloat = 0.0
    
    var body = [SnakeBodyPart]()
    
    convenience init(atPoint point: CGPoint) {
        self.init()
        
        let head = SnakeHead(atPoint: point)
        body.append(head)
        addChild(head)
        
        let newBodyPart = SnakeBodyPart(atPoint: CGPoint(x: body.last!.position.x, y: body.last!.position.y - 7))
        body.append(newBodyPart)
        addChild(newBodyPart)
    }
    
    func addBodyPart() {
        let newBodyPart = SnakeBodyPart(atPoint: CGPoint(x: body.last!.position.x, y: body.last!.position.y - 7))
        body.append(newBodyPart)
        addChild(newBodyPart)
    }
    
    func deleteBodyPart() {
        if body.count > 2 {
            let deleteBodyPart = body.last
            deleteBodyPart!.removeFromParent()
            body.removeLast()
        }
    }
    
    func move() {
        guard !body.isEmpty else { return }
        
        let head = body.first!
        moveHead(head)
        
        for index in (0..<body.count) where index > 0 {
            let previousBodyPart = body[index - 1]
            let currentBodyPart = body[index]
            moveBodyPart(previousBodyPart, current: currentBodyPart)
        }
    }
    
    func moveHead(_ head: SnakeBodyPart) {
        let dx = moveSpeed * sin(angle)
        let dy = moveSpeed * cos(angle)
        
        let nextPosition = CGPoint(x: head.position.x + dx, y: head.position.y + dy)
        
        let moveAction = SKAction.move(to: nextPosition, duration: 1.0)
        
        head.run(moveAction)
    }
    
    func moveBodyPart(_ previouse: SnakeBodyPart, current: SnakeBodyPart) {
        let moveAction = SKAction.move(to: CGPoint(x: previouse.position.x, y: previouse.position.y), duration: 0.1)
        
        current.run(moveAction)
    }
    
    func moveClockwise() {
        angle += .pi / 2
    }
    
    func moveCounterClockwise() {
        angle -= .pi / 2
    }
    
    
    
}
