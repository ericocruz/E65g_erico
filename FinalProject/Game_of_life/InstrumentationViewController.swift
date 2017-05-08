

import UIKit

class InstrumentationViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView! // current table
    @IBOutlet weak var urlTextField: UITextField! // text field with url
    private var objects = [String: [[Int]]]() // the objects will be shown in the table

    override func viewDidLoad() {
        super.viewDidLoad()
        urlTextField.text = "https://dl.dropboxusercontent.com/u/7544475/S65g.json" // default url
        reloadData()// load data
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = UserDefaults.standard.value(forKey: "name") as? String ?? "Configurations" // check if userDefaults has name already. the part of simulation task
    }

    func reloadData(){ // the function to load data from url
        objects = RecognizeJSON.parceJSON(urlSting: urlTextField.text!) // return objects
        self.tableView.reloadData() // update table
    }
    
    func getObjects(index: Int) -> [[Int]] // The function returns array by index
    {
        let key = Array(objects.keys)[index] // get key by index
        return objects[key]! // array for key
    }
    
    func setObject(indexPath: IndexPath?, row: Int, col: Int){ // create or update object
        
        if indexPath != nil{ // if update
            let key = Array(objects.keys)[indexPath!.section] // to check key by header.
            objects[key]?[indexPath!.row][0] = row // update row
            objects[key]?[indexPath!.row][1] = col // update col
        }
        else{
            let key = Array(objects.keys)[objects.keys.count - 1] // else to use last key
            objects[key]?.append([row, col]) // to add new line
        }
        
        tableView.reloadData() // update table
    }
    
    @IBAction func reloadPressed() { // user clicked on reload button
        reloadData() // reload data
    }
    
    @IBAction func addPressed(_ sender: UIBarButtonItem) {
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        return Array(objects.keys)[section] // get headers
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return objects.count // count of section
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return getObjects(index: section).count //count of rows in section
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) 
        let currentValue = getObjects(index: indexPath.section)[indexPath.row]
        cell.textLabel?.text = "\(currentValue[0])  \(currentValue[1])"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true) // deselect row after user clicke on it.
    }

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editLine"{ // when user go to edit line
            if let cell = sender as? UITableViewCell{
                if let vc = segue.destination as? GridEditorViewController{ // get destination ViewController
                    let indexPath = self.tableView.indexPath(for: cell)
                    vc.rows = getObjects(index: indexPath!.section)[indexPath!.row][0]
                    vc.cols = getObjects(index: indexPath!.section)[indexPath!.row][1]
                    vc.indexPath = indexPath
                    vc.parentVC = self
                }
            }
        }else if segue.identifier == "addLine"{ // when user go to add line
            if let vc = segue.destination as? GridEditorViewController{
                vc.parentVC = self
            }
        }
    }
    

}
