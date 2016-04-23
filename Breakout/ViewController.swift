//
//  ViewController.swift
//  Breakout
//
//  Created by Michael Maczynski on 3/5/16.
//  Copyright © 2016 Michael Maczynski. All rights reserved.
//

import UIKit
import Foundation

public extension UIView {
    func fadeIn(duration duration: NSTimeInterval = 1.0) {
        UIView.animateWithDuration(duration, animations: {
            self.alpha = 1.0})}
    func fadeOut(duration duration: NSTimeInterval = 1.0) {
    UIView.animateWithDuration(duration, animations: {
        self.alpha = 0.0})}}

class ViewController: UIViewController, UICollisionBehaviorDelegate {
    
    @IBOutlet weak var livesLabel: UILabel!
    @IBOutlet var scorePlusLabel: UILabel!
    @IBOutlet var startButton: UIButton!
    @IBOutlet var paddle: UIView!
    
    
    @IBOutlet var scoreLabel: UILabel!
    var lives = 5
    var score = 0
    var blockCount = 0
    
    var dynamicAnimator = UIDynamicAnimator()
    var collisionBehavior = UICollisionBehavior()
    var pushBehavior = UIPushBehavior()
    
    
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

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        dynamicAnimator = UIDynamicAnimator(referenceView: view)
        
        initializeGame()

        scorePlusLabel.alpha = 0.0

        allViews.append(paddle)
        bothArray.append(paddle)
        paddleArray.append(paddle)
        paddle.clipsToBounds = true
        
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
        var y:CGFloat = 50 //intitial height from top of view
        
        for _ in 1...5 //rows
        {
            for _ in 1...13//columns
            {
                let block = UIView(frame: CGRectMake(x, y, lob, hob))
                block.backgroundColor = UIColor.whiteColor()
                view.addSubview(block)
                
                blocks.append(block)
                allViews.append(block)
                bothArray.append(block)
                collisionBehavior.addItem(block)
                
                x += (10 + lob) //space between horizontally + length of block
            }
            x = 0 //begin new row at 0
            y += (15 + hob) //space between vertically + height of block
        }
        
        allViews.append(paddle)
        bothArray.append(paddle)
        paddleArray.append(paddle)
        

        
    }
    /************************************/

    func createBall()
    {
        ball = UIView(frame: CGRectMake(300, 300, 20, 20))
        ball.backgroundColor = UIColor.init(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0)
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
            print(blocks.count)
            if item1.isEqual(ball) && item2.isEqual(block) || item1.isEqual(block) && item2.isEqual(ball)
            {
                
                
                if block.backgroundColor == UIColor.whiteColor()
                {
                    block.backgroundColor = UIColor.greenColor()
                    score += 1
                    scorePlusLabel.text = "+1"
                    scorePlusLabel.textColor = UIColor.whiteColor()
                    scorePlusLabel.alpha = 0.0
                    scorePlusLabel.fadeIn(duration: 0.1)
                    scorePlusLabel.fadeOut(duration: 0.3)
                }
                else if block.backgroundColor == UIColor.greenColor()
                {
                block.backgroundColor = UIColor.redColor()
                    
                    score += 5
                    scorePlusLabel.text = "+5"
                    scorePlusLabel.textColor = UIColor.whiteColor()
                    scorePlusLabel.alpha = 0.0
                    scorePlusLabel.fadeIn(duration: 0.1)
                    scorePlusLabel.fadeOut(duration: 0.3)

                }
                else if block.backgroundColor == UIColor.redColor()
                {
                
                    score += 10
                    scorePlusLabel.text = "+10"
                    scorePlusLabel.textColor = UIColor.whiteColor()
                    scorePlusLabel.alpha = 0.0
                    scorePlusLabel.fadeIn(duration: 0.1)
                    scorePlusLabel.fadeOut(duration: 0.3)

                

                    block.removeFromSuperview()
                    collisionBehavior.removeItem(block)
                    
                    blockCount += 1
                    
                
                }
            
                if blockCount == 65
                {
                    wonGame()
                }
                
                
                scoreLabel.text = "Score: \(score)"

            }
        }
        
       }
    /************************************/
    /************************************/

func collisionBehavior(behavior: UICollisionBehavior, beganContactForItem item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying?, atPoint p: CGPoint) {
        if item.isEqual(ball) && p.y > paddle.center.y 
        {
        resetGame()
        lives -= 1
        livesLabel.text = "Lives: \(lives)"

        if lives == 0
        {
        endGame()
        }
            
           
            
        }
    }
    /************************************/

       func setupBehaviors()
    {
        
        let blockDynamicItemBehavior = UIDynamicItemBehavior(items: blocks)
        blockDynamicItemBehavior.density = 1000000.0
        blockDynamicItemBehavior.elasticity = 1.0
        blockDynamicItemBehavior.anchored = true
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
        //paddleDynamicBehavior.resistance = 100
        paddleDynamicBehavior.anchored = true
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
        

        scoreLabel.alpha = 1.0
        
        pushBehavior = UIPushBehavior(items: startBallArray, mode: .Instantaneous)
        pushBehavior.pushDirection = CGVectorMake(0.2, 1.0)
        pushBehavior.magnitude = 0.35
        dynamicAnimator.addBehavior(pushBehavior)
        
        
    }
    func initializeGame()
    {
        setupBehaviors()
        createBlocks()
        createBall()
        startButton.alpha = 1.0
        scoreLabel.alpha = 0.0
    }
    /************************************/

    func wonGame()
    {
            ball.removeFromSuperview()
            collisionBehavior.removeItem(ball)
            dynamicAnimator.updateItemUsingCurrentState(ball)
    
            dynamicAnimator.updateItemUsingCurrentState(paddle)
    
            paddle.hidden = true
    
            for block in blocks
            {
                block.removeFromSuperview()
    
                collisionBehavior.removeItem(block)
            }
    
            startButton.alpha = 0.0
            scoreLabel.alpha = 0.0

    
            let alertView = UIAlertController(title: "You Won", message: "", preferredStyle: .Alert)
            alertView.addAction(UIAlertAction(title: "Exit", style: .Default, handler: { (alertAction) -> Void in
                exit(0)
            }))
            presentViewController(alertView, animated: true, completion: nil)
    
    
    
    }
    /************************************/

    func endGame()
    {
        ball.removeFromSuperview()
        collisionBehavior.removeItem(ball)
        dynamicAnimator.updateItemUsingCurrentState(ball)
        
        dynamicAnimator.updateItemUsingCurrentState(paddle)
        
        paddle.hidden = true

        for block in blocks
        {
        block.removeFromSuperview()
        
        collisionBehavior.removeItem(block)
        }
    
        startButton.alpha = 0.0
        scoreLabel.alpha = 0.0
        
        
        let alertView = UIAlertController(title: "Game Over", message: nil, preferredStyle: .Alert)
        alertView.addAction(UIAlertAction(title: "Exit", style: .Default, handler: { (alertAction) -> Void in
            exit(0)
        }))
        presentViewController(alertView, animated: true, completion: nil)
    }
    
    
    func resetGame()
    {
        lives - 1
        ball.removeFromSuperview()
        collisionBehavior.removeItem(ball)
        dynamicAnimator.updateItemUsingCurrentState(ball)
        
        dynamicAnimator.updateItemUsingCurrentState(paddle)
        
        createBall()
        startButton.alpha = 1.0
        livesLabel.text = "Lives: \(lives)"
    }
    
    /************************************/

   
    
}
























//    func resetGame()
//    {
//        createBlocks()
//
//        setupBehaviors()
//        createBall()
//
//        paddle.hidden = false
//        startButton.alpha = 1.0
//        for block in blocks{
//            print(block)
//        }
//
//    }
//







