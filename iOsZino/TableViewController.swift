//
//  TableViewController.swift
//  iOsZino
//
//  Created by Altamore on 28/02/2019.
//  Copyright © 2019 qaltamore. All rights reserved.
//

import UIKit

struct Pizza: Codable {
    var name: String
    var ingredients: [String]
}

class TableViewController: UITableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet var pizzeList: UITableView!
    
    /*var pizze = ["Calzone", "Regina", "Thon"]*/
    var pizze = [
        Pizza(name: "Calzone", ingredients: ["oeuf", "jambon", "mozarella", "sauce tomate"]),
        Pizza(name: "4 Frômages", ingredients: ["gorgonzola", "mozarella", "chèvre", "parmesan", "sauce tomate"])
    ]
    var pizzeToShow = [Pizza]()
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pizze.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        /*
        let url = URL(string: "http://192.168.43.224:8080/getRecipes")!
        let task = session.dataTask(with: url) { data, response, error in
        }*/
        
        let session = URLSession.shared
        
        // create post request
        let url = URL(string: "http://192.168.43.224:8080/getRecipes")!
        
        // insert json data to the request
        //request.httpBody = jsonData
        
        let task = session.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            var postData = String(data: data, encoding: .utf8)!
            //print(postData)
        }
        
        task.resume()
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath)
        
        if pizzeToShow.isEmpty {
            pizzeToShow = pizze
        }
        
        let pizza = pizzeToShow[indexPath.row].name
        cell.textLabel?.text = pizza
        //cell.detailTextLabel?.text = "Test"
        cell.imageView?.image = UIImage(named: pizza)
        return cell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        print("search Text : ", searchText)
        
        if searchText.isEmpty {
            pizzeToShow = pizze
        }
        for pizza in pizze {
            for ingredient in pizza.ingredients {
                if ingredient == searchText {
                    pizzeToShow.append(pizza)
                }
            }
        }
        
        pizzeList.reloadData()
        
    }
}
