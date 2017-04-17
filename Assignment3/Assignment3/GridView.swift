//
//  GridView.swift
//  Assignment3
//
//  Created by Erico Cruz Lemus on 25.03.17.
//  Copyright © 2017 Harvard Division of Continuing Education. All rights reserved.
//

import UIKit

@IBDesignable class GridView: UIView { // Create a subclass of UIVIew called GridView which has the following characteristics (5 points):

    var size = 20 // 1 Integer: size (defaulting to 20)
    var livingColor: UIColor = UIColor.blue
    var emptyColor: UIColor = UIColor.blue
    var bornColor: UIColor = UIColor.blue
    var diedColor: UIColor = UIColor.blue
    var gridColor: UIColor = UIColor.clear
    var gridWidth: CGFloat = 3.0
    
    private let paragraph = 20 // The distance from left and top board of view
    private var circleSize = 0.0 // size of one circle
    private var lastGraphPoint = 0.0 // The last
    var grid:Grid? // instance of grid 
    
    private var countInLine = 0 // the count of circles in one line

    
    override func draw(_ rect: CGRect) { // override method when view are drawing
        if grid == nil{ // to avoid reinit grid instance when redrawing view
            grid = Grid.init(size, size)
        }
        
        let context = UIGraphicsGetCurrentContext() // get current context of graphics
        
        countInLine = Int(self.frame.width < self.frame.height ? // check what is less to constract grid by less size
            (self.frame.width - CGFloat(paragraph * 2)) / CGFloat(size): // for example if width 320 - 40 (sizes before first board and last board) / count of circle (20 by task)
            (self.frame.height - CGFloat(paragraph * 2)) / CGFloat(size))
        
        circleSize = Double(countInLine - 4) // put circle a little smaller than cell
        
        var currentPositionY = paragraph // first line shoulc be paragraph
        var count = 0 // counter (number of line)
        while count <= size {// for each line
            if count < size{
                var currentPositionX = paragraph // for column same idea
                var countX = 0
                while countX < size{
                    let rect = CGRect(x: CGFloat(currentPositionX) + gridWidth, y: CGFloat(currentPositionY) + gridWidth, width: CGFloat(countInLine - 4) - gridWidth, height: CGFloat(countInLine - 4) - gridWidth) // create rect for circle (circle is written in the rect)
                    drawCircle(row: count, col: countX, rect:rect)// call function to draw circle
                    
                    currentPositionX += countInLine
                    countX += 1
                    
                }
                lastGraphPoint = Double(currentPositionX)
            }
            context?.setLineWidth(gridWidth) // set grid line width
            context?.setStrokeColor(gridColor.cgColor) // set color of grid
            context?.move(to: CGPoint(x: currentPositionY, y: paragraph)) // move pancil to start line
            context?.addLine(to: CGPoint(x: CGFloat(currentPositionY), y: CGFloat(lastGraphPoint)))// draw line from previos point to new position
            context?.move(to: CGPoint(x: paragraph, y: currentPositionY)) // move pancil to new position
            context?.addLine(to: CGPoint(x: CGFloat(lastGraphPoint), y: CGFloat(currentPositionY))) // draw line
            context?.strokePath() // show this lines on view
            currentPositionY += countInLine
            count += 1
        }
    }
    
    func drawCircle(row: Int, col: Int, rect:CGRect){ // draw circle for cell
        let context = UIGraphicsGetCurrentContext()
        
        if grid?._cells[row][col].state == .empty{ // check status to show color that need
            context?.setFillColor(emptyColor.cgColor)
        }else if grid?._cells[row][col].state == .born{
            context?.setFillColor(bornColor.cgColor)
        }else if grid?._cells[row][col].state == .died{
            context?.setFillColor(diedColor.cgColor)
        }else if grid?._cells[row][col].state == .alive{
            context?.setFillColor(livingColor.cgColor)
        }
        
        context?.addEllipse(in: rect) // show board (black bord) of circle
        context?.fillEllipse(in: rect) // fill color of circle
    }
    
    //5. Using touch handling techniques shown in class  and  the toggle method of CellState, toggle the value of a  touched cell from Empty to Living or from Living to Empty depending the current state of the cell and cause a redisplay to happen (20 points)
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) { // called when user click on view
        let touch = touches.first! // get touches (it could be several fingers) and get first one
        let point = touch.location(in: self) // get place of clieck
        if point.x < CGFloat(paragraph) || point.y < CGFloat(paragraph){return} // check, if user tap inside the grid
        if point.x > CGFloat(lastGraphPoint) || point.y > CGFloat(lastGraphPoint){return}
        let col = Int((point.x - CGFloat(paragraph)) / CGFloat(countInLine))
        let row = Int((point.y - CGFloat(paragraph)) / CGFloat(countInLine))
        
        grid?._cells[row][col].state = (grid?._cells[row][col].state.toggle(value: (grid?._cells[row][col].state)!))! // change status by task
        
        self.setNeedsDisplay()// redraw view
        
    }
}
