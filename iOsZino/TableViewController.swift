//
//  TableViewController.swift
//  iOsZino
//
//  Created by Altamore on 28/02/2019.
//  Copyright © 2019 qaltamore. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var pizze = ["Calzone", "Regina", "Thon"]
    
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
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        // insert json data to the request
        //request.httpBody = jsonData
        
        let task = session.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                print(responseJSON)
            }
        }
        
        task.resume()
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath)
        
        let pizza = pizze[indexPath.row]
        cell.textLabel?.text = pizza
        cell.detailTextLabel?.text = "Test"
        cell.imageView?.image = UIImage(named: pizza)
        return cell
    }
}
