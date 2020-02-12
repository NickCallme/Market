//
//  TableViewWarehouseController.swift
//  Market
//
//  Created by Nikita Kolmykov on 11.02.2020.
//  Copyright © 2020 Nikita Kolmykov. All rights reserved.
//

import UIKit

class TableViewWarehouseController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableViewOutlet: UITableView!
    let identifire = "WarehouseProducts"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Добавление стола
        addTable()
        
    }
    
    // MARK: Функция добавления таблицы
    func addTable() {
        
        tableViewOutlet.register(UITableViewCell.self, forCellReuseIdentifier: identifire)
        
        tableViewOutlet.delegate = self
        tableViewOutlet.dataSource = self
        
    }
    
    // MARK: Кол-во ячеек таблицы
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return market.servicesAssembly.warehouse.returnData().count
        
    }
    
    // MARK: Возвращаемые ячейки таблицы
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Массив для ячеек
        var arrayForCell = [String]()
        
        // Массив для обработки
        let arrayObj = market.servicesAssembly.warehouse.returnData()
        
        // Цикл для обработки ячеек
        for obj in arrayObj {
            arrayForCell.append("Товар ID " + obj.key + " , количество : \(obj.value)")
        }
        
        // ячейка
        let cell = tableViewOutlet.dequeueReusableCell(withIdentifier: identifire, for: indexPath)
        
        cell.textLabel?.text = arrayForCell[indexPath.row]
        
        return cell
        
    }
    
    // MARK: - Кнопка назад : Action
    @IBAction func backAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
