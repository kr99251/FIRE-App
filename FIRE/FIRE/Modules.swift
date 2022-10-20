//
//  ViewController.swift
//  FIRE
//
//  Created by Kelly Robinett on 10/11/22.
//

import UIKit
struct Module : Codable{
    var modId : Int
    var modName : String
    //var pages : Array<String>
}
//Parse Json idea from https://stackoverflow.com/questions/24410881/reading-in-a-json-file-using-swift
func loadJson(filename: String) -> Module?{
    let decoder = JSONDecoder()
    guard
        let json = Bundle.main.url(forResource: filename, withExtension: "json"),
        let data = try? Data(contentsOf: json),
        let module = try? decoder.decode(Module.self, from: data)
    else {
        print("Error, JSON File failed to parse")
        return nil
    }
    return module
}
class Modules: UIViewController{
    @IBOutlet weak var titleOutlet: UILabel!
    @IBOutlet weak var textOutlet: UILabel!
    @IBOutlet weak var mainMenuButton: UIButton!
    @IBOutlet weak var mainMenuTab: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        var currentModule = loadJson(filename:"TestModule")
        //Unwrap optional module
        if let currentModule = currentModule{
            //textOutlet.text = currentModule.pages[0]
            titleOutlet.text = currentModule.modName
        }
    }
    //Handles Main Menu botton press
    @IBAction func returnToMenu(_ send: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let secondVC = storyboard.instantiateViewController(identifier: "Menu")

        show(secondVC, sender: self)

    }
}



