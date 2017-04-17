import UIKit

class SimulationViewController: UIViewController, EngineDelegate {

    @IBOutlet weak var gridView: GridView! // outlet of gridView with circles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        StandardEngine.shared.delegate = self // set current controller as file that will be called when delegate called some methods
        
        NotificationCenter.default.addObserver(self, selector: #selector(gridUpdated), name: NSNotification.Name("gridUpdated"), object: nil) // added observer to call function gridUpdated when somewhere 'gridUpdated' called
    }
    
    override func viewDidLayoutSubviews() { // called before device rotated.
        gridView.setNeedsDisplay() // redraw gridView when device was rotated
    }
    
    @IBAction func stepButtonUpInside() { // clicked on step button
        print(StandardEngine.shared.step()) // to call step function of StandardEngine's singleton and print result (I printed because in the task I didn't find how to use result of this function.)
    }
    
    func engineDidUpdate(withGrid:GridProtocol){ // this place will be called when delegate calls engineDidUpdate method
        StandardEngine.shared.grid = withGrid as! Grid // to update current grid with new grid
    }
    
    func gridUpdated(){ // when grid updated
        gridView.setNeedsDisplay() // redraw gridView
    }
}
