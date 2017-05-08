
import UIKit

class GridEditorViewController: UIViewController {

    @IBOutlet weak var rowsTextField: UITextField!
    @IBOutlet weak var colTextField: UITextField!
    @IBOutlet weak var timerRefresh: UISwitch!
    @IBOutlet weak var rateRefresh: UISlider!
    
    var rows = 0
    var cols = 0
    var indexPath: IndexPath?
    weak var parentVC: InstrumentationViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancel)) // create cancel button
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(save)) // create save button
        if rows > 0 {rowsTextField.text = String(rows)} // if rows == 0 not show '0'
        if cols > 0 {colTextField.text = String(cols)}
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func cancel(){
        self.navigationController?.popToRootViewController(animated: true) // go back to previous VC
    }
    
    func save(){ // save changes
        rows = Int(rowsTextField.text!)!
        cols = Int(colTextField.text!)!
        if rows <= 0 || cols <= 0{ // if rows or cols put not correctly to show message
            let alertController = UIAlertController(title: "Invalid count", message: "The value cannot be less 1", preferredStyle: .alert)
            let ok = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alertController.addAction(ok)
            self.navigationController?.present(alertController, animated: true, completion: nil)
            return
        }
        self.navigationController?.popToRootViewController(animated: true)
        parentVC?.setObject(indexPath: indexPath, row:rows, col: cols)
    }
}
