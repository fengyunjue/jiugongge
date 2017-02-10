//
//  ViewController.swift
//  jiugongge
//
//  Created by admin on 17/2/10.
//  Copyright © 2017年 ma. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let numForCol: Int = 3
    let spacing: CGFloat = 15
    let showView = UIView.init()
    
    func random() -> Int{// 1-9
        return Int(arc4random()%9)+1
    }
    
    func randomColor() -> UIColor{
        let red = CGFloat(arc4random_uniform(255))/CGFloat(255.0)
        let green = CGFloat(arc4random_uniform(255))/CGFloat(255.0)
        let blue = CGFloat(arc4random_uniform(255))/CGFloat(255.0)
        return UIColor.init(red:red, green:green, blue:blue , alpha: 1)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "刷新", style: UIBarButtonItemStyle.done, target: self, action: #selector(refreshShowView))
        
        showView.backgroundColor = UIColor.gray
        self.view.addSubview(showView)
        
        constrain(showView) { view in
            view.top >= topLayoutGuideCartography
            view.centerY >= view.superview!.centerY
            view.left == view.superview!.left
            view.width == view.superview!.width
            view.height == view.width ~ 100
        }
        refreshShowView()
    }
    
    func refreshShowView(){
        
        _ = showView.subviews.map{$0.removeFromSuperview()}
        
        for index in 0..<random() {
            let label = UILabel.init()
            label.text = "\(index)"
            label.textAlignment = NSTextAlignment.center
            label.backgroundColor = randomColor()
            showView.addSubview(label)
        }
        
        constrain(showView.subviews) { array in
            for (index, viewProxy) in array.enumerated() {
                viewProxy.width == (viewProxy.superview!.width - spacing * CGFloat(numForCol + 1)) / CGFloat(numForCol)
                viewProxy.height == viewProxy.width
                
                let col : Int = index % numForCol
                let row : Int = index / numForCol
                let topEdge = row == 0 ? viewProxy.superview!.top : array[(row - 1) * numForCol + col].bottom
                let leftEdge = col == 0 ? viewProxy.superview!.left : array[row * numForCol + col - 1].right
                viewProxy.top == topEdge + spacing
                viewProxy.left == leftEdge + spacing
            }
        }
        constrain(showView,showView.subviews.last!) { showViewProxy, lastViewProxy in
            showViewProxy.bottom == lastViewProxy.bottom + spacing
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

