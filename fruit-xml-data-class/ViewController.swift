//
//  ViewController.swift
//  fruit-xml-data-class
//
//  Created by D7703_23 on 2018. 10. 1..
//  Copyright © 2018년 D7703_23. All rights reserved.
//

import UIKit

class ViewController: UIViewController, XMLParserDelegate, UITableViewDataSource,
    UITableViewDelegate{
    @IBOutlet weak var mytableview: UITableView!
    var myFruitData = [FruitData]()
    var dName = ""
    var dcolor = ""
    var dcost = ""
    
    var currentElement = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let path = Bundle.main.url(forResource: "Fruit", withExtension:"xml"){
            if let myParser = XMLParser(contentsOf:path){
                if myParser.parse(){
                    myParser.delegate = self
                    if myParser.parse(){
                      //  print(myFruitData[0].name)
                      //  print(myFruitData[0].color)
                      //  print(myFruitData[0].cost)
                        for i in 0 ..< myFruitData.count {
                            print(myFruitData[i].name)
                            print(myFruitData[i].color)
                            print(myFruitData[i].coat)
                        }
                    }
                    print("파싱 성공")
                }else{
                    print("파싱 오류 발생")
                }
                }else{
                    print("")
            }
        }
    }

    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElement = elementName
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let data = string.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
        
        if !data.isEmpty {
            switch currentElement {
            case "name" : dName = data
            case "color" : dcolor = data
            case "cost" : dcost = data
            default : break
            }
        }
    }
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI namespaceURL:String?,qualifiedName qName: String?){
        if elementName == "item" {
            let myItem = FruitData()
            myItem.name = dName
            myItem.color = dcolor
            myItem.coat = dcost
            myFruitData.append(myItem)
        }
    }
   //UITableView Deiegata
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myFruitData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = mytableview.dequeueReusableCell(withIdentifier: "RE", for: indexPath)
        
        let dName = myCell.viewWithTag(1) as! UILabel
        let dColor = myCell.viewWithTag(2) as! UILabel
        let dcost = myCell.viewWithTag(3) as! UILabel
        dName.text = myFruitData[indexPath.row].name
        dColor.text = myFruitData[indexPath.row].color
        dcost.text = myFruitData[indexPath.row].coat
        
        return myCell
    }
}

