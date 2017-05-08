
import UIKit

@IBDesignable class GridView: UIView { // Create a subclass of UIVIew called GridView which has the following characteristics (5 points):
        
    var livingColor: UIColor = UIColor.blue
    var emptyColor: UIColor = UIColor.gray
    var bornColor: UIColor = UIColor.green
    var diedColor: UIColor = UIColor.red
    var gridColor: UIColor = UIColor.lightGray
    var gridWidth: CGFloat = 3.0
    
    private var _points:[(Int,Int,CellState)] = []// the var to avoid circle of setter.
    var points:[(Int,Int,CellState)]{
        set{// when set value
            for i in 0..<_points.count {
                _points[i] = (_points[i].0, _points[i].1, .empty) // to set empty to each point
            }
            for new in newValue{
                var currentValues = _points.filter({ (current) -> Bool in // to set new values
                    if current.0 == new.0 && current.1 == new.1 { // to find point by col and cel
                        return true
                    }
                    return false
                })
                if currentValues.count > 0{
                    currentValues[0] = new
                }
            }
            _points = newValue
        }
        get{
            return _points.filter({ (point) -> Bool in // to return array with alive or born
                if point.2 == .alive || point.2 == .born{
                    return true
                }
                return false
            })
        }
    }
    
    private let paragraph = 20 // The distance from left and top board of view
    private var circleSize = 0.0 // size of one circle
    private var lastGraphPoint = 0.0 // The last
//    var grid:Grid? // instance of grid
    
    private var countInLine = 0 // the count of circles in one line

    
    override func draw(_ rect: CGRect) { // override method when view are drawing
//        StandardEngine.shared
//        if grid == nil{ // to avoid reinit grid instance when redrawing view
//            grid = Grid.init(size, size)
//        }
        
        let context = UIGraphicsGetCurrentContext() // get current context of graphics
        
        let size = StandardEngine.shared.cols
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
        //context?.restoreGState()
        
        if StandardEngine.shared.grid._cells[row][col] == .empty{ // check status to show color that need
            context?.setFillColor(emptyColor.cgColor)
        }else if StandardEngine.shared.grid._cells[row][col] == .born{
            context?.setFillColor(bornColor.cgColor)
        }else if StandardEngine.shared.grid._cells[row][col] == .died{
            context?.setFillColor(diedColor.cgColor)
        }else if StandardEngine.shared.grid._cells[row][col] == .alive{
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
        
        StandardEngine.shared.grid._cells[row][col] = StandardEngine.shared.grid.toggle(value: (StandardEngine.shared.grid._cells[row][col]))
        self.setNeedsDisplay()// redraw view
        
    }
}
