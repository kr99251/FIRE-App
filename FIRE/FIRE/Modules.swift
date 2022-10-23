//
//  ViewController.swift
//  FIRE
//
//  Created by Kelly Robinett on 10/11/22.
//

import UIKit

struct Module : Codable{
    var modId : Int
    var available: Bool?
    var modName : String
    var pageMax : Int
    var pages : Array<String>
}
//Parse Json idea from https://stackoverflow.com/questions/24410881/reading-in-a-json-file-using-swift
func loadJson(filename: String) -> [Module]?{
    let decoder = JSONDecoder()
    guard
        let json = Bundle.main.url(forResource: filename, withExtension: "json"),
        let data = try? Data(contentsOf: json),
        let modules = try? decoder.decode([Module].self, from: data)
    else {
        print("Error, JSON File failed to parse")
        return nil
    }
    return modules
}
class Modules: UIViewController{
    @IBOutlet weak var titleOutlet: UILabel!
    @IBOutlet weak var textOutlet: UILabel!
    //Handles Main Menu botton press
    @IBAction func unwindToMain(unwindSegue seg: UIStoryboardSegue){}
    var pageNum : Int = 0
    var pageMax : Int = -1
    @IBAction func mainMenuButton(_ sender: Any) {
        performSegue(withIdentifier: "unwindToMain", sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if let currentModule = loadJson(filename:"TestModule")?[0] {//TODO: this is not right it should be passed the specified modId - change for next deliverable
            if let _ = textOutlet {
                textOutlet.text = currentModule.pages[0]
            }

            if let _ = titleOutlet {
                titleOutlet.text = currentModule.modName
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        let currentModule = loadJson(filename:"TestModule")?[0]//TODO: fix this too
        //Unwrap optional module
        if let currentModule = currentModule{
            if let _ = textOutlet {
                textOutlet.text = currentModule.pages[pageNum]
            }
            if let _ = titleOutlet {
                titleOutlet.text = currentModule.modName
            }
        }
    }
    
    @IBAction func prev(_ send:Any){
        if pageNum > 0{
            pageNum = pageNum - 1
        }
        viewWillAppear(true)
    }
    @IBAction func next(_ send:Any){
        if pageNum < pageMax - 1{
            pageNum = pageNum + 1
        }
        viewWillAppear(true)
    }
}



