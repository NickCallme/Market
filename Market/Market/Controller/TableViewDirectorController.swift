//
//  TableViewDirectorController.swift
//  Market
//
//  Created by Nikita Kolmykov on 11.02.2020.
//  Copyright © 2020 Nikita Kolmykov. All rights reserved.
//

import UIKit

class TableViewDirectorController: UIViewController , UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableViewOutlet: UITableView!
    let identifier = "Workers"
    
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
    
    // MARK: Кол-во ячеек таблицы
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return market.servicesAssembly.database.returnDataWorkers().count
        
    }
    
    // MARK: Возвращаемые ячейки
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var arrayForCell = [String]()
        
        let arrayObj = market.servicesAssembly.database.returnDataWorkers()
        
        for obj in arrayObj {
            arrayForCell.append(obj.secondName + " " + obj.firstName + " , Должность : \(obj.position)")
        }
        
        let cell = tableViewOutlet.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        cell.textLabel?.text = arrayForCell[indexPath.row]
        
        return cell
        
    }
    
    // MARK: - Кнопка Назад
    @IBAction func backAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
