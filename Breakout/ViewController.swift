//
//  ViewController.swift
//  Breakout
//
//  Created by Michael Maczynski on 3/5/16.
//  Copyright © 2016 Michael Maczynski. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollisionBehaviorDelegate {
    
    @IBOutlet var startButton: UIButton!
    @IBOutlet var paddle: UIView!

    
    var dynamicAnimator = UIDynamicAnimator()
    var collisionBehavior = UICollisionBehavior()

    
    //length of block
    let lob:CGFloat = 50.0
    
    //height of block
    let hob:CGFloat = 15.0
    
    
    var ball:UIView!
    
    
    var blocks:[UIView] = []
    var startBallArray:[UIView] = []
    var allViews:[UIView] = []
    var bothArray:[UIView] = []
    var paddleArray:[UIView] = []


    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dynamicAnimator = UIDynamicAnimator(referenceView: view)
    
        createBlocks()
        
        let ball = UIView(frame: CGRectMake(300, 300, 20, 20))
        ball.backgroundColor = UIColor.redColor()
        view.addSubview(ball)
        ball.layer.cornerRadius = ball.frame.size.width/2
        ball.clipsToBounds = true
        startBallArray.append(ball)
        allViews.append(ball)
        //ball.hidden = true
        
        
        allViews.append(paddle)
        bothArray.append(paddle)
        paddleArray.append(paddle)
        
        setupBehaviors()
        
    }
   
        func createBlocks()
        {
            
            var x:CGFloat = 0
            var y:CGFloat = 45
            
            for _ in 1...5
            {
                for _ in 1...13
                {
                    let block = UIView(frame: CGRectMake(x, y, lob, hob))
                    block.backgroundColor = UIColor.blackColor()
                    view.addSubview(block)
                    
                    blocks.append(block)
                    allViews.append(block)
                    bothArray.append(block)
                    
                    x += 60
                }
                x = 0
                y += 30
            }
            

        }
    
    
    
        func setupBehaviors()
        {

        let blockDynamicItemBehavior = UIDynamicItemBehavior(items: blocks)
        blockDynamicItemBehavior.density = 1000000.0
        blockDynamicItemBehavior.elasticity = 1.0
        blockDynamicItemBehavior.allowsRotation = true
        dynamicAnimator.addBehavior(blockDynamicItemBehavior)
        
            
        let ballDynamicBehavior = UIDynamicItemBehavior(items: startBallArray)
        ballDynamicBehavior.friction = 0
        ballDynamicBehavior.resistance = 0
        ballDynamicBehavior.elasticity = 1.0
        ballDynamicBehavior.allowsRotation = false
        dynamicAnimator.addBehavior(ballDynamicBehavior)
            
            
        let paddleDynamicBehavior = UIDynamicItemBehavior(items: paddleArray)
        paddleDynamicBehavior.density = 1000
        paddleDynamicBehavior.resistance = 100
        paddleDynamicBehavior.allowsRotation = false
        dynamicAnimator.addBehavior(paddleDynamicBehavior)

            
            
        let collisionBehavior = UICollisionBehavior(items: allViews)
        collisionBehavior.translatesReferenceBoundsIntoBoundary = true
        collisionBehavior.collisionMode = .Everything
        collisionBehavior.collisionDelegate = self
        dynamicAnimator.addBehavior(collisionBehavior)
            
    }
    
    
    
    
    @IBAction func gestureRecognizer(sender: UIPanGestureRecognizer) {
        let panGesture = sender.locationInView(view)
        paddle.center = CGPointMake(panGesture.x, paddle.center.y)
        dynamicAnimator.updateItemUsingCurrentState(paddle)
    }
    
    
    
    @IBAction func startGameAction(sender: UIButton) {
        
        startButton.alpha = 0.0
        
        setupBehaviors()
        
        
        
        let pushBehavior = UIPushBehavior(items: startBallArray, mode: .Instantaneous)
        pushBehavior.pushDirection = CGVectorMake(0.2, 1.0)
        pushBehavior.magnitude = 0.35
        dynamicAnimator.addBehavior(pushBehavior)
        
        
    }
    func collisionBehavior(behavior: UICollisionBehavior, beganContactForItem item1: UIDynamicItem, withItem item2: UIDynamicItem, atPoint p: CGPoint)
    {
        //print(blocks)

        for block in blocks
        {
            //print(block)
//            
//           // if item1 == block
//            {
//                print("hit")
//                block.hidden = true
//            }
            
        }

        
    }



}
































