//
//  GameScene.swift
//  Snake
//
//  Created by Anton Gvozdanov on 03/09/2019.
//  Copyright © 2019 Anton Gvozdanov. All rights reserved.
//

import SpriteKit
import GameplayKit

struct CollisionCategories {
    static let Snake : UInt32 = 0x1 << 0    //1
    static let SnakeHead: UInt32 = 0x1 << 1 //2
    static let Apple: UInt32 = 0x1 << 2     //4
    static let EdgeBody: UInt32 = 0x1 << 3  //8
    static let BadApple: UInt32 = 0x1 << 4  //16
}

class GameScene: SKScene {
    
    var snake: Snake?
    
    override func didMove(to view: SKView) {
        
        backgroundColor = SKColor.darkGray
        
        self.physicsWorld.gravity = CGVector.zero
        
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        
        self.physicsBody?.allowsRotation = false
        
        view.showsPhysics = true
        
        self.physicsWorld.contactDelegate = self
        
        self.physicsBody?.categoryBitMask = CollisionCategories.EdgeBody
        
        //кнопка поворота по часовой стрелке
        let clockwiseButton = SKShapeNode()
        clockwiseButton.path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 50, height: 50)).cgPath
        clockwiseButton.position = CGPoint(x: view.scene!.frame.maxX - 100, y: view.scene!.frame.minY + 50)
        clockwiseButton.fillColor = SKColor.lightGray
        clockwiseButton.strokeColor = SKColor.lightGray
        clockwiseButton.lineWidth = 5
        clockwiseButton.name = "clockwiseButton"
        
        self.addChild(clockwiseButton)
        
        //Кнопка против часовой
        let counterClockwiseButton = SKShapeNode()
        counterClockwiseButton.path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 50, height: 50)).cgPath
        counterClockwiseButton.position = CGPoint(x: view.scene!.frame.minX + 50, y: view.scene!.frame.minY + 50)
        counterClockwiseButton.fillColor = SKColor.lightGray
        counterClockwiseButton.strokeColor = SKColor.lightGray
        counterClockwiseButton.lineWidth = 5
        counterClockwiseButton.name = "counterClockwiseButton"
        
        self.addChild(counterClockwiseButton)
        
        createApple()
        createBadApple()
        
        snake = Snake(atPoint: CGPoint(x: view.scene!.frame.midX, y: view.scene!.frame.midY))
        self.addChild(snake!)
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let touchLocation = touch.location(in: self)
            
            guard let touchedNode = self.atPoint(touchLocation) as? SKShapeNode,
                touchedNode.name == "clockwiseButton" || touchedNode.name == "counterClockwiseButton" else {return}
            
            touchedNode.fillColor = .red
            
            if touchedNode.name == "counterClockwiseButton" {
                snake!.moveCounterClockwise()
            } else if touchedNode.name == "clockwiseButton" {
                snake!.moveClockwise()
            }
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.children.forEach { node in
            guard let buttonNode = node as? SKShapeNode,
            buttonNode.name == "clockwiseButton" || buttonNode.name == "counterClockwiseButton" else {return}
            
            buttonNode.fillColor = .lightGray
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        snake!.move()
    }
    
    func createApple() {
        let randX = CGFloat(arc4random_uniform(UInt32(view!.scene!.frame.maxX-10)) + 1)
        let randY = CGFloat(arc4random_uniform(UInt32(view!.scene!.frame.maxY-10)) + 1)
        
        let apple = Apple(position: CGPoint(x: randX, y: randY))
        self.addChild(apple)
    }
    
    func createBadApple() {
        let randX = CGFloat(arc4random_uniform(UInt32(view!.scene!.frame.maxX-10)) + 1)
        let randY = CGFloat(arc4random_uniform(UInt32(view!.scene!.frame.maxY-10)) + 1)
        
        let badApple = BadApple(position: CGPoint(x: randX, y: randY))
        self.addChild(badApple)
    }
}

extension GameScene: SKPhysicsContactDelegate {
    
    func didBegin(_ contact: SKPhysicsContact) {
        let bodies = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        let collisionObject = bodies ^ CollisionCategories.SnakeHead
        
        switch collisionObject {
        case CollisionCategories.Apple:
            let apple = contact.bodyA.node is Apple ? contact.bodyA.node : contact.bodyB.node
            apple?.removeFromParent()
            createApple()
            snake?.addBodyPart()
        case CollisionCategories.Snake:
            snake?.removeFromParent()
            snake = nil
            snake = Snake(atPoint: CGPoint(x: self.view!.scene!.frame.midX, y: self.view!.scene!.frame.midY))
            self.addChild(snake!)
        case CollisionCategories.EdgeBody:
            snake?.removeFromParent()
            snake = nil
            snake = Snake(atPoint: CGPoint(x: self.view!.scene!.frame.midX, y: self.view!.scene!.frame.midY))
            self.addChild(snake!)
        case CollisionCategories.BadApple:
            let badApple = contact.bodyA.node is BadApple ? contact.bodyA.node : contact.bodyB.node
            badApple?.removeFromParent()
            createBadApple()
            snake?.deleteBodyPart()
        default:
            break
        }
    }
}
