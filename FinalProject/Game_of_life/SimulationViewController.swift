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
        gridView.setNeedsDisplay()
    }
    
    func engineDidUpdate(withGrid:GridProtocol){ // this place will be called when delegate calls engineDidUpdate method
        StandardEngine.shared.grid = withGrid as! Grid // to update current grid with new grid
    }
    
    func gridUpdated(){ // when grid updated
        gridView.setNeedsDisplay() // redraw gridView
    }
    
    @IBAction func resetPressed(){
        StandardEngine.shared.grid = Grid.init(10, 10) // reset game to new with empty board
        gridView.setNeedsDisplay() // refresh grid view
    }
    
    @IBAction func saveUser(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Set name", message: "Enter your name", preferredStyle: .alert) // show alert controller
        let ok = UIAlertAction(title: "Ok", style: .default) { (_) in
            UserDefaults.standard.set(alertController.textFields?[0].text, forKey: "name") // create ok button
        }
        alertController.addAction(ok) // add ok button to controller
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil) // add cancel button
        alertController.addAction(cancel) // add cancel button to controller
        alertController.addTextField(configurationHandler: nil) // add text field
        self.navigationController?.present(alertController, animated: true, completion: nil) // show alert controller
    }
}
