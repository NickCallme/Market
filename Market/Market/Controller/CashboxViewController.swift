//
//  ViewController.swift
//  Market
//
//  Created by Nikita Kolmykov on 29.01.2020.
//  Copyright © 2020 Nikita Kolmykov. All rights reserved.
//

import UIKit

class CashboxViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {

    @IBOutlet weak var tableViewOutlet: UITableView!
    var identifier = "Product"
    
    var qr = QRCode()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Перезагрузка таблицы при входе
        tableViewOutlet.reloadData()
        // Добавление стола
        addTable()
        
    }
    
    
    
    // Добавить стол
    func addTable() {
        
        tableViewOutlet.register(UITableViewCell.self, forCellReuseIdentifier: identifier)
        
        tableViewOutlet.delegate = self
        tableViewOutlet.dataSource = self
        
    }
    
    

    
    
    //MARK: Количество ячеек в таблице
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return market.cashMachine.returnCheck().description().count
    }
    
    //MARK: Возвращаемые ячейки
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let arrayObj = market.cashMachine.returnCheck().description()
        
        let cell = tableViewOutlet.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        
        cell.textLabel?.text = arrayObj[indexPath.row]
        
        return cell
        
    }
    
    // MARK: - Кнопка SCAN : Action
    @IBAction func scanAction(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "QrViewCashboxController") as! QrViewCashboxController
        vc.modalPresentationStyle = .currentContext
        present(vc, animated: true, completion: nil)
        
    }
    
    
    //MARK: - Кнопка добавить позицию вручную : Action
    @IBAction func addPositionManuallyAction(_ sender: Any) {
        
        // Создание алерт контроллера
        let alertController = UIAlertController(title: "Добавление позиции", message: "Укажите ID и кол-во продукта", preferredStyle: .alert)
        
        // Кнопка добавить и ее функции
        let actionAdd = UIAlertAction(title: "Добавить", style: .default) { (action) in
            
            // Переменные для функции
            guard let id = alertController.textFields?.first?.text else {return}
            guard let countStr = alertController.textFields?.last?.text else {return}
            guard let count = Double(countStr) else {return}
            
            // Переменный для вариации
            let warehouseProduct = market.servicesAssembly.warehouse.findProduct(id: id)
            let catalogProduct = market.servicesAssembly.catalog.find(id)
            
            if catalogProduct == nil {
                
                // Создание алерт кнотроллера
                let alertControllerFail = UIAlertController(title: "", message: "", preferredStyle: .alert)
                alertControllerFail.title = "Ошибка"
                alertControllerFail.message = "По указанному ID не существует продукта"
                
                // Кнопка Ок
                let actionOK = UIAlertAction(title: "OK", style: .default, handler: nil)
                
                // Добавление кнопки ОК
                alertControllerFail.addAction(actionOK)
                
                self.present(alertControllerFail, animated: true, completion: nil)
                
            } else if warehouseProduct == nil {
                
                // Создание алерт кнотроллера
                let alertControllerFail = UIAlertController(title: "", message: "", preferredStyle: .alert)
                alertControllerFail.title = "Ошибка"
                alertControllerFail.message = "Указанный товар отсутствует на складе"
                
                // Кнопка Ок
                let actionOK = UIAlertAction(title: "OK", style: .default, handler: nil)
                
                // Добавление кнопки ОК
                alertControllerFail.addAction(actionOK)
                
                self.present(alertControllerFail, animated: true, completion: nil)
                
            } else if count > warehouseProduct!.1 {
                
                // Создание алерт кнотроллера
                let alertControllerFail = UIAlertController(title: "", message: "", preferredStyle: .alert)
                alertControllerFail.title = "Ошибка"
                alertControllerFail.message = "Недостаточно товара на складе"
                
                // Кнопка Ок
                let actionOK = UIAlertAction(title: "OK", style: .default, handler: nil)
                
                // Добавление кнопки ОК
                alertControllerFail.addAction(actionOK)
                
                self.present(alertControllerFail, animated: true, completion: nil)
                
            } else {
                
                // Функция добавления позиции в чек
                market.cashMachine.addPosition(id: id, count: count)
                
                // Перезагрузка таблицы
                self.tableViewOutlet.reloadData()
            }
            
        }
        
        // Кнопка отмены
        let actionCancel = UIAlertAction(title: "Отмена", style: .default, handler: nil)
        // Цвет кнопки отмены
        actionCancel.setValue(UIColor.red, forKey: "titleTextColor")
        
        // Добавление поля для ID
        alertController.addTextField { (textFieldID) in
            textFieldID.placeholder = "ID Продукта"
        }
        // Добавление поля для Кол-ва
        alertController.addTextField { (textFieldCount) in
            textFieldCount.placeholder = "Количество"
        }
        
        // Добавление кнопки ДОБАВИТЬ
        alertController.addAction(actionAdd)
        // Добавление кнопки ОТМЕНА
        alertController.addAction(actionCancel)
        
        
        present(alertController, animated: true, completion: nil)
    }
    
    //MARK: - Кнопка оплаты безналичными
    @IBAction func cashlessAction(_ sender: Any) {
        
        // Получение чека для проверки
        let check = market.cashMachine.returnCheck().returnData()
        
        if check.count == 0 {
            
            // Создание алерт контроллера
            let alertControllerFail = UIAlertController(title: "", message: "", preferredStyle: .alert)
            alertControllerFail.title = "Ошибка"
            alertControllerFail.message = "В чеке отсутствуют продукты"
            
            // Кнопка ОК
            let actionOK = UIAlertAction(title: "OK", style: .default, handler: nil)
            
            // Добавление кнопки ОК
            alertControllerFail.addAction(actionOK)
            
            present(alertControllerFail, animated: true, completion: nil)
            
        } else {
            
            //Создани алерт контроллера
            let alerControllerAccept = UIAlertController(title: "Оплата", message: "Подтвердите безналичную оплату", preferredStyle: .alert)
            //Кнопка подтверждения
            let actionAccept = UIAlertAction(title: "Подтвердить", style: .default) { (accept) in
                
                // Оплата безналичными и получение чека
                let check = market.cashMachine.purchaseCashless()
                // Перезагрузка таблицы
                self.tableViewOutlet.reloadData()
                
                // Сообщение для алерт контроллера
                var messegeForAlert = String()
                
                // Цикл для обработки сообщения в алерт контроллер
                for line in check {
                    
                    messegeForAlert.append(line + "\n")
                    
                }
                
                // Cоздание алерт контроллера
                let alertControllerOK = UIAlertController(title: "ЧЕК", message: messegeForAlert, preferredStyle: .alert)
                // Создание кнопки ОК
                let alertActionOK = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                // Добавление кнопки ОК
                alertControllerOK.addAction(alertActionOK)
                
                self.present(alertControllerOK, animated: true, completion: nil)
                
            }
            
            // Кнопка отмены
            let actionCancel = UIAlertAction(title: "Отмена", style: .default, handler: nil)
            // Цвет кнопки отмены
            actionCancel.setValue(UIColor.red, forKey: "titleTextColor")
            
            // Добавление кнопки подтвердить
            alerControllerAccept.addAction(actionAccept)
            // Добавления кнопки отмена
            alerControllerAccept.addAction(actionCancel)
            
            present(alerControllerAccept, animated: true, completion: nil)
            
        }
        
    }
    
    
    //MARK: - Кнопка оплаты наличными : Action
    @IBAction func cashAction(_ sender: Any) {
        
        // Получение чека для проверки
        let check = market.cashMachine.returnCheck().returnData()
        
        if check.count == 0 {
            
            // Создание алерт контроллера
            let alertControllerFail = UIAlertController(title: "", message: "", preferredStyle: .alert)
            alertControllerFail.title = "Ошибка"
            alertControllerFail.message = "В чеке отсутствуют продукты"
            
            // Кнопка ОК
            let actionOK = UIAlertAction(title: "OK", style: .default, handler: nil)
            
            // Добавление кнопки ОК
            alertControllerFail.addAction(actionOK)
            
            present(alertControllerFail, animated: true, completion: nil)
            
        } else {
            
            //Создани алерт контроллера
            let alerControllerAccept = UIAlertController(title: "Оплата", message: "Подтвердите наличную оплату", preferredStyle: .alert)
            //Кнопка подтверждения
            let actionAccept = UIAlertAction(title: "Подтвердить", style: .default) { (accept) in
                
                // Оплата безналичными и получение чека
                let check = market.cashMachine.purchaseCash()
                // Перезагрузка таблицы
                self.tableViewOutlet.reloadData()
                
                // Сообщение для алерт контроллера
                var messegeForAlert = String()
                
                // Цикл для обработки сообщения в алерт контроллер
                for line in check {
                    
                    messegeForAlert.append(line + "\n")
                    
                }
                
                // Cоздание алерт контроллера
                let alertControllerOK = UIAlertController(title: "ЧЕК", message: messegeForAlert, preferredStyle: .alert)
                // Создание кнопки ОК
                let alertActionOK = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                // Добавление кнопки ОК
                alertControllerOK.addAction(alertActionOK)
                
                self.present(alertControllerOK, animated: true, completion: nil)
                
            }
            
            // Кнопка отмены
            let actionCancel = UIAlertAction(title: "Отмена", style: .default, handler: nil)
            // Цвет кнопки отмены
            actionCancel.setValue(UIColor.red, forKey: "titleTextColor")
            
            // Добавление кнопки подтвердить
            alerControllerAccept.addAction(actionAccept)
            // Добавления кнопки отмена
            alerControllerAccept.addAction(actionCancel)
            
            present(alerControllerAccept, animated: true, completion: nil)
            
        }
        
    }
    
    //MARK: - Кнопка удалить позицию : Action
    @IBAction func deletePositionAction(_ sender: Any) {
        
        // ID для удаления позиции
        var id = String()
        // Кол-во для удаление из позиции
        var count = Double()
        
        // Создание алерт контроллера
        let alertController = UIAlertController(title: "Удаление позиции", message: "Укажите ID и кол-во продукта", preferredStyle: .alert)
        
        // Кнопка удалить и ее функции
        let actionAdd = UIAlertAction(title: "Удалить", style: .default) { (action) in
            
            guard let text = alertController.textFields?.first?.text else {return}
            id = text
            guard let quantity = alertController.textFields?.last?.text else {return}
            guard let quantityDouble = Double(quantity) else {return}
            count = quantityDouble
            
            // Функция удаления позиции из чека
            market.cashMachine.deletePosition(id: id, count: count)
            
            // Перезагрузка таблицы
            self.tableViewOutlet.reloadData()
        }
        // Цвет кнопки удалить
        actionAdd.setValue(UIColor.red, forKey: "titleTextColor")
        
        // Кнопка отмены
        let actionCancel = UIAlertAction(title: "Отмена", style: .default, handler: nil)
        
        // Добавление поля для ID
        alertController.addTextField { (textFieldID) in
            textFieldID.placeholder = "ID Продукта"
        }
        // Добавление поля для Кол-ва
        alertController.addTextField { (textFieldCount) in
            textFieldCount.placeholder = "Количество"
        }
        
        // Добавление кнопки ДОБАВИТЬ
        alertController.addAction(actionAdd)
        // Добавление кнопки ОТМЕНА
        alertController.addAction(actionCancel)
        
        
        present(alertController, animated: true, completion: nil)
        
    }
    
    //MARK: - Кнопка отмены покупки : Action
    @IBAction func cancelPayAction(_ sender: Any) {
        
        // Создаю алерт контроллер
        let alertController = UIAlertController(title: "Отмена", message: "Подтвердите отмену чека", preferredStyle: .alert)
        // Кнопка подтвердить и ее функция
        let actionAccept = UIAlertAction(title: "Подтвердить", style: .default) { (action) in
            
            // Отмена чека
            market.cashMachine.cancelPurchase()
            // Обновление таблицы
            self.tableViewOutlet.reloadData()
            
        }
        // Цвет кнопки подтвердить
        actionAccept.setValue(UIColor.red, forKey: "titleTextColor")
        
        
        // Кнопка отмены
        let actionCancel = UIAlertAction(title: "Отмена", style: .default, handler: nil)
        
        // Добваление кнопки подтвердить
        alertController.addAction(actionAccept)
        // Добавление кнопки отмена
        alertController.addAction(actionCancel)
        
        present(alertController, animated: true, completion: nil)
        
    }
    
    
    //MARK: - Кнопка выйти : Action
    @IBAction func exitAction(_ sender: Any) {
        
        // Создание алерт контроллера
        let alertController = UIAlertController(title: "", message: "", preferredStyle: .alert)
        alertController.title = "Выход"
        alertController.message = "Вы уврены что хотите выйти?"
        
        // Кнопка Да
        let actionYes = UIAlertAction(title: "Да", style: .default) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        // Цвет кнопки да
        actionYes.setValue(UIColor.red, forKey: "titleTextColor")
        
        // Кнопка Нет
        let actionNo = UIAlertAction(title: "Нет", style: .default, handler: nil)
        
        // Добавление кнопки ДА
        alertController.addAction(actionYes)
        // Добавление кнопки НЕТ
        alertController.addAction(actionNo)
        
        present(alertController, animated: true, completion: nil)
        
    }
    
    
    

}


