//
//  ViewController.swift
//  Breakout
//
//  Created by Michael Maczynski on 3/5/16.
//  Copyright © 2016 Michael Maczynski. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollisionBehaviorDelegate {
    
    
    var dynamicAnimator = UIDynamicAnimator()
    var collisionBehavior = UICollisionBehavior()
    var ball:UIView!
    var paddle:UIView!
    
    let panRec = UIPanGestureRecognizer()

    
    //length of block
    let lob:CGFloat = 50.0
    
    //height of block
    let hob:CGFloat = 15.0
    
    //columns
    let columns = 13
    
    //rows
    let rows: CGFloat = 4

    var blocks:[UIView] = []
    var startBallArray:[UIView] = []
    var allViews:[UIView] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dynamicAnimator = UIDynamicAnimator(referenceView: view)
        
        var x:CGFloat = 0
        var y:CGFloat = 30
        
        for _ in 1...4
        {
            for _ in 1...13
            {
                let block = UIView(frame: CGRectMake(x, y, lob, hob))
                block.backgroundColor = UIColor.blackColor()
                view.addSubview(block)
                
                blocks.append(block)
                allViews.append(block)
                
                x += 60
            }
            x = 0
            y += 30
        }

        
        
        let ball = UIView(frame: CGRectMake(300, 300, 20, 20))
        ball.backgroundColor = UIColor.redColor()
        view.addSubview(ball)
        ball.layer.cornerRadius = ball.frame.size.width/2
        ball.clipsToBounds = true
        startBallArray.append(ball)
        allViews.append(ball)

        
        let paddle = UIView(frame: CGRectMake(260, 600, 70, 10))
        paddle.backgroundColor = UIColor.blackColor()
        view.addSubview(paddle)
        allViews.append(paddle)

        
        panRec.addTarget(self, action: "draggedView:")
        paddle.addGestureRecognizer(panRec)

        
        
        setupBehaviors()
        
    }
   
        func setupBehaviors()
        {
            //let boundary = UIView(frame: CGRectMake(0, 600, 1000, 15))
            //boundary.backgroundColor = UIColor.blackColor()
            //view.addSubview(boundary)
            //blocks.append(boundary)
            
            
        let dynamicItemBehavior = UIDynamicItemBehavior(items: blocks)
        dynamicItemBehavior.density = 1000000.0
        dynamicItemBehavior.elasticity = 1.0
        dynamicItemBehavior.allowsRotation = false
        dynamicAnimator.addBehavior(dynamicItemBehavior)
        
        let ballDynamicItemBehavior = UIDynamicItemBehavior(items: startBallArray)
        ballDynamicItemBehavior.friction = 0.0
        ballDynamicItemBehavior.resistance = 0.0
        ballDynamicItemBehavior.elasticity = 1.2
        dynamicAnimator.addBehavior(ballDynamicItemBehavior)

        let collisionBehavior = UICollisionBehavior(items: allViews)
        collisionBehavior.translatesReferenceBoundsIntoBoundary = true
        collisionBehavior.collisionMode = .Everything
        collisionBehavior.collisionDelegate = self
        dynamicAnimator.addBehavior(collisionBehavior)
            
        let pushBehavior = UIPushBehavior(items: startBallArray, mode: .Continuous)
        pushBehavior.magnitude = 0.3
        pushBehavior.pushDirection = CGVectorMake(0, 0.9)
        dynamicAnimator.addBehavior(pushBehavior)

        
    }
    
    @IBAction func paddleMovement(sender: UIPanGestureRecognizer) {
              // dynamicAnimator.updateItemUsingCurrentState(paddle)
    }
    
    func draggedView(sender:UIPanGestureRecognizer){
        self.view.bringSubviewToFront(sender.view!)
        var translation = sender.translationInView(self.view)
        sender.view!.center = CGPointMake(sender.view!.center.x + translation.x, sender.view!.center.y + translation.y)
        sender.setTranslation(CGPointZero, inView: self.view)

    }
    
    func collisionBehavior(behavior: UICollisionBehavior, beganContactForItem item1: UIDynamicItem, withItem item2: UIDynamicItem, atPoint p: CGPoint)
    {
        //print(blocks)

        for block in blocks
        {
           // print(block)
        }

        
    }



}
































