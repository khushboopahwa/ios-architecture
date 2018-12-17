//
//  ViewController.swift
//  Lift
//
//  Created by Khushboo Pahwa on 21/06/18.
//  Copyright © 2018 Khushboo Pahwa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var animatedLiftImg: UIImageView!
    
    var currentFloorNumber: Int = 0
    var elevatorCallArray = [Int]()
    var destinationFloor:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK:- --------------IBActions------------------
    @IBAction func button0Clicked(_ sender: UIButton) {
        sender.isSelected = true
        sender.setTitleColor(.white, for: .selected)
        elevatorCallArray.append(sender.tag) //adding lift call to array of calls
        
        checkCurrentFloorNumber(sender: sender)
    }
    
    @IBAction func button1Clicked(_ sender: UIButton) {
        sender.isSelected = true
        sender.setTitleColor(.white, for: .selected)
        elevatorCallArray.append(sender.tag)
       
        checkCurrentFloorNumber(sender: sender)
    }
    
    @IBAction func button2Clicked(_ sender: UIButton) {
        sender.isSelected = true
        sender.setTitleColor(.white, for: .selected)
        elevatorCallArray.append(sender.tag)
        
        checkCurrentFloorNumber(sender: sender)
    }
    
    @IBAction func button3Clicked(_ sender: UIButton) {
        sender.isSelected = true
        sender.setTitleColor(.white, for: .selected)
        elevatorCallArray.append(sender.tag)
        
        checkCurrentFloorNumber(sender: sender)
    }
    
    @IBAction func button4Clicked(_ sender: UIButton) {
        sender.isSelected = true
        sender.setTitleColor(.white, for: .selected)
        elevatorCallArray.append(sender.tag)
        
        checkCurrentFloorNumber(sender: sender)
        
    }
    
    //MARK:- -----------------Class Functions--------------------
    func checkIfEmpty(_ sender: UIButton) {
        if elevatorCallArray.isEmpty {
            UIView.setAnimationDelay(2)
        } else {
            for i in elevatorCallArray.indices {
                if elevatorCallArray[i] > currentFloorNumber{
                    elevatorCallArray.sort(by: <)
                    destinationFloor = elevatorCallArray.last
                    moveUp(self.view.viewWithTag(self.elevatorCallArray[i]) as! UIButton)
                } else if sender.tag != 0 {
                    elevatorCallArray.sort(by: >)
                    destinationFloor = elevatorCallArray.last
                    moveDown(self.view.viewWithTag(self.elevatorCallArray[i]) as! UIButton)
                } else {
                    animatedLiftImg.transform = CGAffineTransform(translationX: 0, y: -CGFloat(Double(self.view.frame.minY) - 135.0 * Double(elevatorCallArray[i])))
                }
            }
        }
    }
    
    func checkCurrentFloorNumber(sender: UIButton) {
        if sender.tag == currentFloorNumber {
            print("same floor")
        } else {
            checkIfEmpty(sender)
        }
    }
    
    func moveUp(_ sender: UIButton) {
        for i in elevatorCallArray.indices {
            if currentFloorNumber < elevatorCallArray[i] {
                let distanceMoved = 135.0 * Double(elevatorCallArray[i])
                UIView.animate(withDuration: 4, delay: 0, options: .curveLinear, animations: {
                    self.currentFloorNumber = self.elevatorCallArray[i]
                    self.animatedLiftImg.transform = CGAffineTransform(translationX: 0, y: CGFloat(-(distanceMoved)))
                    UIView.commitAnimations()
                }) { (completed) in
                    if self.currentFloorNumber != self.destinationFloor {
                        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (timer) in
                            sender.isSelected = false
                            sender.setTitleColor(.blue, for: .normal)
                            self.moveUp(self.view.viewWithTag(self.elevatorCallArray[i]) as! UIButton )
                            self.checkIfEmpty(self.view.viewWithTag(self.elevatorCallArray[i]) as! UIButton)
                        })
                    } else {
                        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (timer) in
                            sender.isSelected = false
                            sender.setTitleColor(.blue, for: .normal)
                        })
                    }
                }
            }
        }
        self.elevatorCallArray.remove(at: 0)
    }
    
    func moveDown(_ sender: UIButton) {
        for i in elevatorCallArray.indices {
            if currentFloorNumber > elevatorCallArray[i] {
                let distanceMoved = Double(self.view.frame.minY) - 135.0 * Double(elevatorCallArray[i])
                UIView.animate(withDuration: 5, animations: {
                    self.currentFloorNumber = self.elevatorCallArray[i]
                    self.animatedLiftImg.transform = CGAffineTransform(translationX: 0, y: CGFloat(distanceMoved))
                    UIView.commitAnimations()
                }) { (completed) in
                    if self.currentFloorNumber != self.destinationFloor {
                        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (timer) in
                            sender.isSelected = false
                            sender.setTitleColor(.blue, for: .normal)
                            self.moveDown(self.view.viewWithTag(self.elevatorCallArray[i]) as! UIButton )
                            self.checkIfEmpty(self.view.viewWithTag(self.elevatorCallArray[i]) as! UIButton )
                        })
                    } else {
                        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (timer) in
                            sender.isSelected = false
                            sender.setTitleColor(.blue, for: .normal)
                        })
                    }
                }
            }
        }
       self.elevatorCallArray.remove(at: 0)
    }
}

