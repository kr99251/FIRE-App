//
//  ModulesScroll.swift
//  FIRE
//
//  Created by Noel Desmarais on 10/21/22.
//

import UIKit
class ModuleScroll: UIViewController {
    struct Mod : Decodable{
        var modId : Int
        var available: Bool
        var modName : String
        var pageMax : Int
        var pages : Array<String>
    }
    @IBOutlet weak var scrollView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let dataFromFile = getJsonData(fileName: "TestModule"){
            print(dataFromFile)
            if let modules = parseData(jsonData: dataFromFile){
                setupScrollView(buttons:modules)
                
            }
        }else{
            print("Data is nil")
        }
        
    }

    
    func getJsonData(fileName: String) -> Data? {
        do {
            if let path = Bundle.main.url(forResource: fileName, withExtension: "json"), let jsonData = try String(contentsOf: path).data(using: .utf8){
                    return jsonData
                }
        }
        catch{
            print("getJsonData Error")
        }
        return nil
        
    }
    
    func parseData(jsonData: Data) -> [Mod]?{
        do {
            let decodedData = try JSONDecoder().decode([Mod].self,
                                                       from: jsonData)
            return decodedData
        } catch {
            print(error)
        }
        
        return nil
    }

    
    
    func setupScrollView(buttons modules: [Mod]){
        for module in modules{
            let oneBtn : UIButton = {
                let button = UIButton()
                button.setTitle(module.modName, for: .normal)
                if module.available{
                    button.backgroundColor = .green
                }else{
                    button.backgroundColor = .red
                }
                button.contentHorizontalAlignment = .center
                button.contentVerticalAlignment = .center
                button.tag = module.modId
                button.heightAnchor.constraint(equalToConstant: 300).isActive = true
                let id = module.modId
                button.addTarget(self, action: #selector(openModule), for: .touchUpInside)
                return button
                
            }()
            
            scrollView.addArrangedSubview(oneBtn)
        }
    }
    @objc func openModule(moduleId: Int){
        present(Modules(), animated: false)
    }

}
    


