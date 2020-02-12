//
//  WarehouseViewController.swift
//  Market
//
//  Created by Nikita Kolmykov on 04.02.2020.
//  Copyright © 2020 Nikita Kolmykov. All rights reserved.
//

import UIKit

class WarehouseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    


    // MARK: - Кнопка Добавить : Action
    @IBAction func addAction(_ sender: Any) {
        
        // Создание алерт контроллера
        let alertController = UIAlertController(title: "", message: "", preferredStyle: .alert)
        alertController.title = "Добавить"
        alertController.message = "Укажите ID продукта и количество"
        
        // Кнока Добавить и ее функции
        let actionAdd = UIAlertAction(title: "Добавить", style: .default) { (action) in
            
            // Переменные для функции
            guard let id = alertController.textFields?[0].text else {return}
            guard let countStr = alertController.textFields?[1].text else {return}
            guard let count = Double(countStr) else {return}
            
            // Переменная для вариаций
            let product = market.servicesAssembly.warehouse.findProduct(id: id)
            
            if product == nil {
                
                // Создание алерт контроллера
                let alertControllerCreate = UIAlertController(title: "", message: "", preferredStyle: .alert)
                alertControllerCreate.title = "Новый товар"
                alertControllerCreate.message = "Создать новый товар по ID " + id + " в кол-ве \(count)"
                
                // Кнопка Создать и ее функции
                let actionCreate = UIAlertAction(title: "Создать", style: .default) { (action) in
                    
                    market.servicesAssembly.warehouse.add(id: id, count: count)
                    
                }
                
                // Кнопка Отмены
                let actionCancel = UIAlertAction(title: "Отмена", style: .default, handler: nil)
                // Цвет кноки отмена
                actionCancel.setValue(UIColor.red, forKey: "titleTextColor")
                
                // Добавление кнопки СОЗДАТЬ
                alertControllerCreate.addAction(actionCreate)
                // Добавление кнопки ОТМЕНА
                alertControllerCreate.addAction(actionCancel)
                
                self.present(alertControllerCreate, animated: true, completion: nil)
                
            } else {
                
                // Содание алерт контроллера
                let alertControllerAdd = UIAlertController(title: "", message: "", preferredStyle: .alert)
                alertControllerAdd.title = "Добавление"
                alertControllerAdd.message = "Добавить к товару под ID " + id + " в размере \(product!.1) еще \(count), итог: \(product!.1 + count)"
                
                // Кнопка Добавить
                let actionAdd = UIAlertAction(title: "Добавить", style: .default) { (action) in
                    
                    // Функция добавления
                    market.servicesAssembly.warehouse.add(id: id, count: count)
                    
                }
                
                // Кнопка Отмены
                let actionCancel = UIAlertAction(title: "Отмена", style: .default, handler: nil)
                // Цвет кнопки отмены
                actionCancel.setValue(UIColor.red, forKey: "titleTextColor")
                
                // Добавление кнопки ДОБАВИТЬ
                alertControllerAdd.addAction(actionAdd)
                // Добавление кнопки ОТМЕНА
                alertControllerAdd.addAction(actionCancel)
                
                self.present(alertControllerAdd, animated: true, completion: nil)
            }
            
        }
        
        // Кнопка Отмены
        let actionCancel = UIAlertAction(title: "Отмена", style: .default, handler: nil)
        // Цвет кнопки отмена
        actionCancel.setValue(UIColor.red, forKey: "titleTextColor")
        
        // Текстовое поле ID продукта
        alertController.addTextField { (idTextField) in
            idTextField.placeholder = "ID продукта"
        }
        // Текстовое поле Кол-ва
        alertController.addTextField { (countTextField) in
            countTextField.placeholder = "Количество"
        }
        
        // Добавление кнопки Добавить
        alertController.addAction(actionAdd)
        // Добавление кнопки Отмена
        alertController.addAction(actionCancel)
        
        present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - Кнопка Поменять ID : Action
    @IBAction func changeIDAction(_ sender: Any) {
        
        // Создание алерт контроллера
        let alertController = UIAlertController(title: "", message: "", preferredStyle: .alert)
        alertController.title = "Смена ID"
        alertController.message = "Укажите старый и новый ID"
        
        // Кнопка Изменить
        let actionChange = UIAlertAction(title: "Изменить", style: .default) { (action) in
            
            // Переменные для функции
            guard let oldID = alertController.textFields?[0].text else {return}
            guard let newID = alertController.textFields?[1].text else {return}
            
            // Переменные для вариаций
            let oldPlace = market.servicesAssembly.warehouse.findProduct(id: oldID)
            let newPlace = market.servicesAssembly.warehouse.findProduct(id: newID)
            
            if oldPlace == nil {
                
                // Создание алерт контроллера
                let alertControllerFail = UIAlertController(title: "", message: "", preferredStyle: .alert)
                alertControllerFail.title = "Ошибка"
                alertControllerFail.message = "По указанному старому ID отсутствует Продукт"
                
                // Кнопка Ок
                let actionOK = UIAlertAction(title: "OK", style: .default, handler: nil)
                
                //  Добавление кнопки ОК
                alertControllerFail.addAction(actionOK)
                
                self.present(alertControllerFail, animated: true, completion: nil)
                
            } else if newPlace != nil {
                
                // Создание алерт контроллера
                let alertControllerFail = UIAlertController(title: "", message: "", preferredStyle: .alert)
                alertControllerFail.title = "Ошибка"
                alertControllerFail.message = "По указанному новому ID уже существует Продукт"
                
                // Кнопка Ок
                let actionOK = UIAlertAction(title: "OK", style: .default, handler: nil)
                
                //  Добавление кнопки ОК
                alertControllerFail.addAction(actionOK)
                
                self.present(alertControllerFail, animated: true, completion: nil)
                
            } else {
                
                // Создание алерт контроллера
                let alertControllerSuccsec = UIAlertController(title: "", message: "", preferredStyle: .alert)
                alertControllerSuccsec.title = "Подтвердите"
                alertControllerSuccsec.message = "Сменить ID товара с " + oldID + " на " + newID
                
                // Кнопка Да
                let actionYes = UIAlertAction(title: "Да", style: .default) { (action) in
                    
                    // Функция смены ID
                    market.servicesAssembly.warehouse.changeID(id: oldID, newID: newID)
                    
                }
                
                // Кнопка Нет
                let actionNo = UIAlertAction(title: "Нет", style: .default, handler: nil)
                // Цвет кнопки нет
                actionNo.setValue(UIColor.red, forKey: "titleTextColor")
                
                // Добавление кнопки ДА
                alertControllerSuccsec.addAction(actionYes)
                // Добавление кнопки НЕТ
                alertControllerSuccsec.addAction(actionNo)
                
                self.present(alertControllerSuccsec, animated: true, completion: nil)
            }
            
        }
        
        // Кнопка Отмена
        let actionCanel = UIAlertAction(title: "Отмена", style: .default, handler: nil)
        // Цвет кнопки отмена
        actionCanel.setValue(UIColor.red, forKey: "titleTextColor")
        
        // Текстовое поле старого ID
        alertController.addTextField { (oldIdTextField) in
            oldIdTextField.placeholder = "Старый ID"
        }
        // Текстовое поле нового ID
        alertController.addTextField { (newTextField) in
            newTextField.placeholder = "Новый ID"
        }
        
        // Добавление кнопки ИЗМЕНИТЬ
        alertController.addAction(actionChange)
        // Добавление кнопки ОТМЕНА
        alertController.addAction(actionCanel)
        
        present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - Кнопка Удалить Кол-во : Action
    @IBAction func deleteCountAction(_ sender: Any) {
        
        // Создание алерт контроллера
        let alertController = UIAlertController(title: "", message: "", preferredStyle: .alert)
        alertController.title = "Удаление кол-ва"
        alertController.message = "Укажите ID и количество удаляемого товара"
        
        // Создание кнопки Удалить
        let actionDelete = UIAlertAction(title: "Удалить", style: .default) { (action) in
            
            // Переменные для функции
            guard let id = alertController.textFields?[0].text else {return}
            guard let countStr = alertController.textFields?[1].text else {return}
            guard let count = Double(countStr) else {return}
            
            // Переменная для вариаций
            let product = market.servicesAssembly.warehouse.findProduct(id: id)
            
            if product == nil {
                
                // Создание алерт контроллера
                let alertControllerFail = UIAlertController(title: "", message: "", preferredStyle: .alert)
                alertControllerFail.title = "Ошибка"
                alertControllerFail.message = "По указанному ID отсутствует продукт"
                
                // Кнопка ОК
                let actionOK = UIAlertAction(title: "OK", style: .default, handler: nil)
                
                // Добавление кнопки ОК
                alertControllerFail.addAction(actionOK)
                
                self.present(alertControllerFail, animated: true, completion: nil)
                
            } else {
                
                // Создание алерт контроллера
                let alertControllerSuccsec = UIAlertController(title: "", message: "", preferredStyle: .alert)
                alertControllerSuccsec.title = "Подтвердите"
                alertControllerSuccsec.message = "Удалить у товара по ID " + id + " \(count) из \(product!.1), остаток: \( product!.1 - count ) ?"
                
                // Кнопка ДА
                let actionYes = UIAlertAction(title: "Да", style: .default) { (action) in
                    
                    // Функция удаления кол-ва товара
                    market.servicesAssembly.warehouse.remove(id: id, count: count)
                    
                }
                
                // Кнока Нет
                let actionNo = UIAlertAction(title: "Нет", style: .default, handler: nil)
                // Цвет кнопки нет
                actionNo.setValue(UIColor.red, forKey: "titleTextColor")
                
                // Добавление кнопки ДА
                alertControllerSuccsec.addAction(actionYes)
                // Добавление кнопки НЕТ
                alertControllerSuccsec.addAction(actionNo)
                
                self.present(alertControllerSuccsec, animated: true, completion: nil)
            }
            
        }
        // Цвет кнопки Удалить
        actionDelete.setValue(UIColor.red, forKey: "titleTextColor")
        
        // Создание кнопки отмена
        let actionCancel = UIAlertAction(title: "Отмена", style: .default, handler: nil)
        
        // Текстовое поле ID продрука
        alertController.addTextField { (idTextField) in
            idTextField.placeholder = "ID продукта"
        }
        // Текстовое поле кол-во продукта
        alertController.addTextField { (countTextField) in
            countTextField.placeholder = "Количество"
        }
        
        // Добавление кнопки УДАЛИТЬ
        alertController.addAction(actionDelete)
        // Добавление кнопки ОТМЕНА
        alertController.addAction(actionCancel)
        
        present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - Кнопка Удалить Продукт : Action
    @IBAction func deleteProductAction(_ sender: Any) {
        
        // Создание алерт контроллера
        let alertController = UIAlertController(title: "", message: "", preferredStyle: .alert)
        alertController.title = "Удаление продукта"
        alertController.message = "Укажить ID удаляемого продукта"
        
        // Кнопка Удалить
        let actionDelete = UIAlertAction(title: "Удалить", style: .default) { (action) in
            
            // Переменная для функции
            guard let id = alertController.textFields?[0].text else {return}
            
            // Переменная для вариаций
            let product = market.servicesAssembly.warehouse.findProduct(id: id)
            
            if product == nil {
                
                // Создание алерт контроллера
                let alertControllerFail = UIAlertController(title: "", message: "", preferredStyle: .alert)
                alertControllerFail.title = "Ошибка"
                alertControllerFail.message = "По указанному ID отсутствует продукт"
                
                // Кнопка ОК
                let actionOK = UIAlertAction(title: "OK", style: .default, handler: nil)
                
                // Добавление кнопки ОК
                alertControllerFail.addAction(actionOK)
                
                self.present(alertControllerFail, animated: true, completion: nil)
                
            } else {
                
                // Создание алерт контроллера
                let alertControllerSuccsec = UIAlertController(title: "", message: "", preferredStyle: .alert)
                alertControllerSuccsec.title = "Подтвердите"
                alertControllerSuccsec.message = "Вы уверены что хотите полностью удалить продукт по ID " + id + " ?"
                
                // Кнопка Да
                let actionYes = UIAlertAction(title: "Да", style: .default) { (action) in
                    
                    // Функция удаления продукта
                    market.servicesAssembly.warehouse.removeProduct(id: id)
                    
                }
                
                // Кнопка Нет
                let actionNo = UIAlertAction(title: "Нет", style: .default, handler: nil)
                
                // Добавление кнопки ДА
                alertControllerSuccsec.addAction(actionYes)
                // Добавление кнопки НЕТ
                alertControllerSuccsec.addAction(actionNo)
                
                self.present(alertControllerSuccsec, animated: true, completion: nil)
            }
            
        }
        
        // Кнопка Отмены
        let actionCancel = UIAlertAction(title: "Отмена", style: .default, handler: nil)
        
        // Текстовое поле ID продукта
        alertController.addTextField { (idTextField) in
            idTextField.placeholder = "ID продукта"
        }
        
        // Добавление кнопки УДАЛИТЬ
        alertController.addAction(actionDelete)
        // Добавление кнопки ОТМЕНА
        alertController.addAction(actionCancel)
        
        present(alertController, animated: true, completion: nil)
        
    }
    
    // MARK: - Кнопка просмотра склада : Action
    @IBAction func checkWarehouseAction(_ sender: Any) {
        
        // Переменная главного сториборда
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        // Ижект нового контроллера
        let vc = storyboard.instantiateViewController(identifier: "TableViewWarehouseController") as! TableViewWarehouseController
        // Стиль контроллера
        vc.modalPresentationStyle = .currentContext
        
        present(vc, animated: true, completion: nil)
        
    }
    
    
    // MARK: - Кнопка выхода : Action
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
