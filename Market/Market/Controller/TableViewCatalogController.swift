//
//  TableViewCatalogController.swift
//  Market
//
//  Created by Nikita Kolmykov on 11.02.2020.
//  Copyright © 2020 Nikita Kolmykov. All rights reserved.
//

import UIKit

class TableViewCatalogController: UIViewController , UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableViewOutlet: UITableView!
    var identifier = "CatalogProducts"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addTable()
        
    }
    

    // MARK: Функция добавления стола
    func addTable() {
        
        tableViewOutlet.register(UITableViewCell.self, forCellReuseIdentifier: identifier)
        
        tableViewOutlet.delegate = self
        tableViewOutlet.dataSource = self
        
    }
    
    // MARK: Кол-во возвращаемых ячеек
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         
        return market.servicesAssembly.catalog.returnData().count
        
     }
     
    // MARK: Возвращаемые ячейки
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         
        var arrayForCell = [String]()
        
        let arrayObj = market.servicesAssembly.catalog.returnData()
        
        for obj in arrayObj {
            arrayForCell.append( "ID " + obj.key + " " + obj.value.name + " , цена за \(obj.value.unit) = \(obj.value.price) руб." )
        }
        
        let cell = tableViewOutlet.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        
        cell.textLabel?.text = arrayForCell[indexPath.row]
        
        return cell
     }
    
    
    // MARK: - Кнопка назад : Action
    @IBAction func backAction(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
    }
    

}
