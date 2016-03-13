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
    
    @IBOutlet var numberOfLivesLabel: UILabel!
    var numberOfLives = 10
    
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
    
    
    
    /************************************/

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dynamicAnimator = UIDynamicAnimator(referenceView: view)
        
        
        createBlocks()
        createBall()
        setupBehaviors()

        
        allViews.append(paddle)
        bothArray.append(paddle)
        paddleArray.append(paddle)
        
        
    }
    /************************************/

    @IBAction func gestureRecognizer(sender: UIPanGestureRecognizer) {
        let panGesture = sender.locationInView(view)
        paddle.center = CGPointMake(panGesture.x, paddle.center.y)
        dynamicAnimator.updateItemUsingCurrentState(paddle)
    }
    
    /************Create UIViews***********/
    
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
                collisionBehavior.addItem(block)
                
                x += 60
            }
            x = 0
            y += 30
        }
        
        allViews.append(paddle)
        bothArray.append(paddle)
        paddleArray.append(paddle)
        

        
    }
    
    func createBall()
    {
        ball = UIView(frame: CGRectMake(300, 300, 20, 20))
        ball.backgroundColor = UIColor.redColor()
        view.addSubview(ball)
        ball.layer.cornerRadius = ball.frame.size.width/2
        ball.clipsToBounds = true
        startBallArray.append(ball)
        allViews.append(ball)
    }
    /************************************/

    /*********Collision Functions********/

    
    func collisionBehavior(behavior: UICollisionBehavior, beganContactForItem item1: UIDynamicItem, withItem item2: UIDynamicItem, atPoint p: CGPoint)
    {
        
        
        for block in blocks
        {
            collisionBehavior.addItem(block)
            
            if item1.isEqual(ball) && item2.isEqual(block) || item1.isEqual(block) && item2.isEqual(ball)
            {
                
//                
//                if block.backgroundColor == UIColor.blackColor()
//                {
//                    block.backgroundColor = UIColor.redColor()
//                }
//                else if block.backgroundColor == UIColor.redColor()
//                {
//                block.backgroundColor = UIColor.blueColor()
//                }
//                else if block.backgroundColor == UIColor.blueColor()
//                {
                
                
                    block.removeFromSuperview()
                    collisionBehavior.removeItem(block)
                //}
                
                
            }
        }
        
        
    }
/*
func collisionBehavior(behavior: UICollisionBehavior, beganContactForItem item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying?, atPoint p: CGPoint) {
        if item.isEqual(ball) && p.y > paddle.center.y {
            numberOfLives--
            numberOfLivesLabel.text = "Lives: \(numberOfLives)"
            
            if numberOfLives != 0
            {
                dynamicAnimator.updateItemUsingCurrentState(ball)
                ball.center = view.center

            }
            else
            {
                endGame()
            }
            
        }
    }*/
    /************************************/

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
        
        
        
        collisionBehavior = UICollisionBehavior(items: allViews)
        collisionBehavior.translatesReferenceBoundsIntoBoundary = true
        collisionBehavior.collisionMode = .Everything
        collisionBehavior.collisionDelegate = self
        dynamicAnimator.addBehavior(collisionBehavior)
        
    }
    /************************************/

     /***********Game Functions**********/

    
    
    
    
    @IBAction func startGameAction(sender: UIButton) {
        
        startButton.alpha = 0.0
        
        setupBehaviors()
        
        
        
        let pushBehavior = UIPushBehavior(items: startBallArray, mode: .Instantaneous)
        pushBehavior.pushDirection = CGVectorMake(0.7, 1.0)
        pushBehavior.magnitude = 0.35
        dynamicAnimator.addBehavior(pushBehavior)
        
        
    }
    func resetGame()
    {
        setupBehaviors()
        createBlocks()
        createBall()
        startButton.alpha = 1.0

    }
    func endGame()
    {
        ball.removeFromSuperview()
        collisionBehavior.removeItem(ball)
        dynamicAnimator.updateItemUsingCurrentState(ball)
        dynamicAnimator.updateItemUsingCurrentState(paddle)
        

        for block in blocks
        {
            block.removeFromSuperview()
        
        collisionBehavior.removeItem(block)
        }
    
    
        
        let alertView = UIAlertController(title: "Game Over", message: "You ran out of lives.", preferredStyle: .Alert)
        alertView.addAction(UIAlertAction(title: "Play Again", style: .Default, handler: { (alertAction) -> Void in
            self.resetGame()
        }))
        //alertView.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        presentViewController(alertView, animated: true, completion: nil)
    }
    /************************************/

}
































