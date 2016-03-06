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
    
    //distance between blocks horizontally
    var dbbh:CGFloat = 10.0
    
    //distance between blocks vertically
    let dbbv:CGFloat = 5.0
    
    //length of block
    let lob:CGFloat = 50.0
    
    //height of block
    let hob:CGFloat = 15.0
    
    //columns
    let columns = 12
    
    //rows
    let rows: CGFloat = 1
    
    //initial distance
    let id: CGFloat = 50.0
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dynamicAnimator = UIDynamicAnimator(referenceView: view)
        
        setupStartBallView()
        setupViews()
        
    }
    
    
    func setupStartBallView()
    {
        let startBall = UIView(frame: CGRectMake(50, 50, 20, 20))
        startBall.backgroundColor = UIColor.redColor()
        view.addSubview(startBall)
        startBall.layer.cornerRadius = startBall.frame.size.width/2
        startBall.clipsToBounds = true
        addBallDynamicBehavior([startBall])

    }
    
    
 
    
    
    
    func setupViews()
    {

        let sq1 = UIView(frame: CGRectMake(0, 50, lob, hob))
        sq1.backgroundColor = UIColor.blackColor()
        view.addSubview(sq1)
        let sq2 = UIView(frame: CGRectMake(lob + dbbh, 50, lob, hob))
        sq2.backgroundColor = UIColor.redColor()
        view.addSubview(sq2)

        let sq3 = UIView(frame: CGRectMake(2 * (lob + dbbh), 50, lob, hob))
        sq3.backgroundColor = UIColor.blackColor()
        view.addSubview(sq3)

        let sq4 = UIView(frame: CGRectMake(3 * (lob + dbbh), 50, lob, hob))
        sq4.backgroundColor = UIColor.blackColor()
        view.addSubview(sq4)

        let sq5 = UIView(frame: CGRectMake(4 * (lob + dbbh), 50, lob, hob))
        sq5.backgroundColor = UIColor.redColor()
        view.addSubview(sq5)

        let sq6 = UIView(frame: CGRectMake(5 * (lob + dbbh), 50, lob, hob))
        sq6.backgroundColor = UIColor.redColor()
        view.addSubview(sq6)

        let sq7 = UIView(frame: CGRectMake(6 * (lob + dbbh), 50, lob, hob))
        sq7.backgroundColor = UIColor.blackColor()
        view.addSubview(sq7)

        let sq8 = UIView(frame: CGRectMake(7 * (lob + dbbh), 50, lob, hob))
        sq8.backgroundColor = UIColor.blackColor()
        view.addSubview(sq8)

        let sq9 = UIView(frame: CGRectMake(8 * (lob + dbbh), 50, lob, hob))
        sq9.backgroundColor = UIColor.redColor()
        view.addSubview(sq9)

        let sq10 = UIView(frame: CGRectMake(9 * (lob + dbbh), 50, lob, hob))
        sq10.backgroundColor = UIColor.redColor()
        view.addSubview(sq10)

        let sq11 = UIView(frame: CGRectMake(10 * (lob + dbbh), 50, lob, hob))
        sq11.backgroundColor = UIColor.redColor()
        view.addSubview(sq11)

        let sq12 = UIView(frame: CGRectMake(11 * (lob + dbbh), 50, lob, hob))
        sq12.backgroundColor = UIColor.blackColor()
        view.addSubview(sq12)

        let sq13 = UIView(frame: CGRectMake((12 * (lob + dbbh)) - 2, 50, lob, hob))
        sq13.backgroundColor = UIColor.blackColor()
        view.addSubview(sq13)

        
        addBlocksDynamicBehavior([sq1, sq2, sq3, sq4, sq5, sq6, sq7, sq8, sq9, sq10, sq11, sq12, sq13])
    }
    
    func addBlocksDynamicBehavior(array: [UIView])
    {
        let dynamicItemBehavior = UIDynamicItemBehavior(items: array)
        dynamicItemBehavior.density = 1.0
        dynamicItemBehavior.friction = 0.0
        dynamicItemBehavior.resistance = 0.0
        dynamicItemBehavior.elasticity = 1.0
        dynamicAnimator.addBehavior(dynamicItemBehavior)
        
        
        let collisionBehavior = UICollisionBehavior(items: array)
        collisionBehavior.translatesReferenceBoundsIntoBoundary = true
        collisionBehavior.collisionMode = .Everything
        collisionBehavior.collisionDelegate = self
        dynamicAnimator.addBehavior(collisionBehavior)
        
        
        
        
    }
    
    func addBallDynamicBehavior(ballArray: [UIView])
    {
        let dynamicItemBehavior = UIDynamicItemBehavior(items: ballArray)
        dynamicItemBehavior.density = 1.0
        dynamicItemBehavior.friction = 0.0
        dynamicItemBehavior.resistance = 0.0
        dynamicItemBehavior.elasticity = 1.0
        dynamicAnimator.addBehavior(dynamicItemBehavior)
        
        
        let pushBehavior = UIPushBehavior(items: ballArray, mode: .Instantaneous)
        pushBehavior.magnitude = 0.1
        pushBehavior.pushDirection = CGVectorMake(0.5, 0.5)
        dynamicAnimator.addBehavior(pushBehavior)
        
        
        let collisionBehavior = UICollisionBehavior(items: ballArray)
        collisionBehavior.translatesReferenceBoundsIntoBoundary = true
        collisionBehavior.collisionMode = .Everything
        collisionBehavior.collisionDelegate = self
        dynamicAnimator.addBehavior(collisionBehavior)
    }

    
    func collisionBehavior(behavior: UICollisionBehavior, beganContactForItem item1: UIDynamicItem, withItem item2: UIDynamicItem, atPoint p: CGPoint) {
        print(p)
    }
}





























/*

//row1
let sq1 = UIView(frame: CGRectMake(0, id, lob, hob))
sq1.backgroundColor = UIColor.blackColor()
view.addSubview(sq1)

for _ in 0...columns
{
    let sq12 = UIView(frame: CGRectMake(m1h * (lob + dbbh), id, lob, hob))
    sq12.backgroundColor = UIColor.blackColor()
    view.addSubview(sq12)
    m1h++
}

//row2

let sq2 = UIView(frame: CGRectMake(0, 55, lob, hob))
sq2.backgroundColor = UIColor.blackColor()
view.addSubview(sq2)

for _ in 0...columns
{
    let sq22 = UIView(frame: CGRectMake(m2 * (lob + dbbh), 55, lob, hob))
    sq22.backgroundColor = UIColor.blackColor()
    view.addSubview(sq22)
    m2++
    m2v++
}

//row3

let sq3 = UIView(frame: CGRectMake(0, 25 + 55, lob, hob))
sq3.backgroundColor = UIColor.blackColor()
view.addSubview(sq3)

for _ in 0...columns
{
    let sq3 = UIView(frame: CGRectMake(m3 * (lob + dbbh), 25 + 55, lob, hob))
    sq3.backgroundColor = UIColor.blackColor()
    view.addSubview(sq3)
    m3++
    m3v++
}

//row4

let sq4 = UIView(frame: CGRectMake(0, 50 + 55, lob, hob))
sq4.backgroundColor = UIColor.blackColor()
view.addSubview(sq4)

for _ in 0...columns
{
    let sq42 = UIView(frame: CGRectMake(m4 * (lob + dbbh), 50 + 55, lob, hob))
    sq42.backgroundColor = UIColor.blackColor()
    view.addSubview(sq42)
    m4++
    m4v++
}
*/






//    //mutiplier row 1
//    var m1h: CGFloat = 1.0
//
//    //mutiplier row 2
//    var m2: CGFloat = 1.0
//
//    //mutiplier row 2 vertical
//    var m2v: CGFloat = 1.0
//
//    //mutiplier row 3
//    var m3: CGFloat = 1.0
//
//    //mutiplier row 3 vertical
//    var m3v: CGFloat = 1.0
//
//    //mutiplier row 4
//    var m4: CGFloat = 1.0
//
//    //mutiplier row 4 vertical
//    var m4v: CGFloat = 1.0
