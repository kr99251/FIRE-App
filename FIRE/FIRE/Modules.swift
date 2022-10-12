//
//  ViewController.swift
//  FIRE
//
//  Created by Kelly Robinett on 10/11/22.
//

import UIKit
struct Module : Codable{
    let title : String
    let text : String
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
class Modules: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }


}

