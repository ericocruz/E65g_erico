import UIKit

class StatisticsViewController: UIViewController {

    @IBOutlet weak var emptyLabel: UILabel! // empty label on statistic view
    @IBOutlet weak var bornLabel: UILabel! // born label on statistic view
    @IBOutlet weak var aliveLabel: UILabel! // alive label on statistic view
    @IBOutlet weak var diedLabel: UILabel! // died label on statistic view
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateLabels), name: NSNotification.Name("gridUpdated"), object: nil) // added observer on gridUpdated method and call updateLabels method if called
    }
    
    override func viewWillAppear(_ animated: Bool) { // the function called when user go to statistic tab
        super.viewWillAppear(animated) // to call this methos of superclass
        updateLabels() // update labels text
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateLabels(){
        emptyLabel.text = "Empty: " + StandardEngine.shared.grid._cells.map({ (arrayCellState) -> Int in
            return arrayCellState.filter({ (cellState) -> Bool in
                if cellState == .empty {return true}
                return false
            }).count
        }).reduce(0, +).description // in this plase I put text to empty label. we have array of array of CellState elements. It looks like [[CellState]]. first we take first sub array (arrayCellState) and use function reduce. By this function we can calculate all elements. For example the array of [1,2,3,5,8,10].reduce(0,+) will return 29. Also we have second level of block where we return array from array where cellState equal to .empty. So we have some lines and rows (10 to 10). For example for each line we couning the count of elements of .empty. After we have array with count of each line. After we are doing + of all this values and have some result like 97. After we call 97.description to convert Int value to String
        
        bornLabel.text = "Empty: " + StandardEngine.shared.grid._cells.map({ (arrayCellState) -> Int in // for this same idea but with .born type
            return arrayCellState.filter({ (cellState) -> Bool in
                if cellState == .born {return true}
                return false
            }).count
        }).reduce(0, +).description
        
        aliveLabel.text = "Empty: " + StandardEngine.shared.grid._cells.map({ (arrayCellState) -> Int in
            return arrayCellState.filter({ (cellState) -> Bool in
                if cellState == .alive {return true}
                return false
            }).count
        }).reduce(0, +).description
        
        diedLabel.text = "Empty: " + StandardEngine.shared.grid._cells.map({ (arrayCellState) -> Int in
            return arrayCellState.filter({ (cellState) -> Bool in
                if cellState == .died {return true}
                return false
            }).count
        }).reduce(0, +).description
    }

}
