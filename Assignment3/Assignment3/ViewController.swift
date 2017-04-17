//
//  ViewController.swift
//  Assignment3
//
//  Created by Van Simmons on 1/15/17.
//  Copyright © 2017 Harvard Division of Continuing Education. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if let gridView = self.view as? GridView{
            
            gridView.size = 20 // Use these values: size: 20
            gridView.livingColor = .green
            gridView.bornColor = UIColor(red: 0, green: 1, blue: 0, alpha: 0.6)
            gridView.emptyColor = .darkGray
            gridView.diedColor = UIColor(red: 128.0/255, green: 128.0/255, blue: 128.0/255, alpha: 0.6)
            gridView.gridColor = .black
            gridView.gridWidth = 2.0
            //	Use these values: size: 20, livingColor = some green, bornColor = same shade of green with .6 alpha,  emptyColor = darkGray, diedColor = same shade of grey  with  .6 alpha, gridColor = black, gridWidth = 2.0
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //Add a button labeled: "Step" which will iterate the grid when pressed using your modified version of Grid  (20 points)
    @IBAction func stepButtonUpInside(_ sender: UIButton) {
        if let view = self.view as? GridView{ // convert UIView to GridView
            let historicGridIterator = view.grid?.makeIterator() // make Iterator
            print("historic: \(historicGridIterator)") // log it
        }
    }

}

