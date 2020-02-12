//
//  CatalogViewController.swift
//  Market
//
//  Created by Nikita Kolmykov on 04.02.2020.
//  Copyright © 2020 Nikita Kolmykov. All rights reserved.
//

import UIKit

class CatalogViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    // MARK: Кнопка добавить продукт : Action
    @IBAction func addProductAction(_ sender: Any) {
        
        // Создание алерт контроллера
        let alertController = UIAlertController(title: "Создайте продукт", message: "Укажите ID, Наименованние, Цену, Eд.Измерения", preferredStyle: .alert)
        // Кнопка добавить
        let actionAdd = UIAlertAction(title: "Добавить", style: .default) { (action) in
            
            // переменные для создания Продукта
            guard let id = alertController.textFields?[0].text else {return}
            guard let name = alertController.textFields?[1].text else {return}
            guard let priceStr = alertController.textFields?[2].text else {return}
            guard let price = Float(priceStr) else {return}
            guard let unitStr = alertController.textFields?[3].text else {return}
            
            var unit : Unit {
                switch unitStr {
                case "кг": return .кг
                case "шт": return .шт
                default:
                    return .шт
                }
            }
            
            market.servicesAssembly.catalog.add(id: id, Product(name: name, price: price, unit: unit))
            
            
        }
        // Кнопка отмены
        let actionCancel = UIAlertAction(title: "Отмена", style: .default, handler: nil)
        // Цвет кнопки отмены
        actionCancel.setValue(UIColor.red, forKey: "titleTextColor")
        
        // Текстовое поле для ID
        alertController.addTextField { (idTextField) in
            idTextField.placeholder = "ID продукта"
        }
        // Текстовое поле для Наименованния
        alertController.addTextField { (nameTextField) in
            nameTextField.placeholder = "Наименованние"
        }
        // Текстовое поле для Цены товара
        alertController.addTextField { (priceTextField) in
            priceTextField.placeholder = "Цена товара"
        }
        // Текстовое поле для указания Ед.измерения
        alertController.addTextField { (unitTextField) in
            unitTextField.placeholder = "Ед.измерения (кг/шт)"
        }
        
        // Добавление кнопки ДОБАВИТЬ
        alertController.addAction(actionAdd)
        // Добавление кнопки ОТМЕНА
        alertController.addAction(actionCancel)
        
        present(alertController, animated: true, completion: nil)
    }
    
    // MARK: Кнопка поменять ID : Action
    @IBAction func changeIDAction(_ sender: Any) {
        // Создание алерт контроллера
        let alertController = UIAlertController(title: "Смена ID продукта", message: "Укажите старый и новый ID", preferredStyle: .alert)
        // Кнопка поменять и ее функция
        let actionChange = UIAlertAction(title: "Поменять", style: .default) { (action) in
            
            // Переменные для функции смены ID
            guard let oldID = alertController.textFields?[0].text else {return}
            guard let newID = alertController.textFields?[1].text else {return}
            
            // Места для проверки
            let oldPlaceProduct = market.servicesAssembly.catalog.find(oldID)
            let newPlaceProduct = market.servicesAssembly.catalog.find(newID)
            
            if oldPlaceProduct == nil {
                
                // Создание алерт контроллера
                let alertControllerFail = UIAlertController(title: "Ошибка", message: "Под указанным старым ID не существует продукта", preferredStyle: .alert)
                // Кнопка ОК
                let actionOK = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                // Добавление кнопки ОК
                alertControllerFail.addAction(actionOK)
                
                self.present(alertControllerFail, animated: true, completion: nil)
                
            } else if newPlaceProduct != nil {
                
                // Создание алерт контроллера
                let alertControllerFail = UIAlertController(title: "Ошибка", message: "Под указанным новым ID уже существует продукт", preferredStyle: .alert)
                // Кнопка ОК
                let actionOK = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                // Добавление кнопки ОК
                alertControllerFail.addAction(actionOK)
                
                self.present(alertControllerFail, animated: true, completion: nil)
                
            } else {
                
                // Переменная для messege алерт контроллера
                guard let product = market.servicesAssembly.catalog.find(oldID) else {return}
                
                // Создание алерт контроллера
                let alertControllerSuccsec = UIAlertController(title: "", message: "", preferredStyle: .alert)
                alertControllerSuccsec.title = "Смена ID"
                alertControllerSuccsec.message = "Вы уверены что хотите сменить ID продукта " + product.name + " с " + oldID + " на " + newID
                
                // Кнопка Да
                let actionYes = UIAlertAction(title: "Да", style: .default) { (action) in
                    
                    // Функция смены ID
                    market.servicesAssembly.catalog.changeID(id: oldID, newID: newID)
                    
                }
                
                // Кнопка Нет
                let actionNo = UIAlertAction(title: "Нет", style: .default, handler: nil)
                // Цвет кнопки Нет
                actionNo.setValue(UIColor.red, forKey: "titleTextColor")
                
                // Добавление кнопки ОК
                alertControllerSuccsec.addAction(actionYes)
                // Добавление кнопки НЕТ
                alertControllerSuccsec.addAction(actionNo)
                
                self.present(alertControllerSuccsec, animated: true, completion: nil)
            }
            
            
        }
        // Кнопка отмены
        let actionCancel = UIAlertAction(title: "Отмена", style:  .default, handler: nil)
        // Цвет кнопки отмена
        actionCancel.setValue(UIColor.red, forKey: "titleTextColor")
        
        // Текстове поле старого ID
        alertController.addTextField { (oldIDTextField) in
            oldIDTextField.placeholder = "Старый ID"
        }
        // Текстовое поле нового ID
        alertController.addTextField { (newIDTextField) in
            newIDTextField.placeholder = "Новый ID"
        }
        
        // Добавление кнопки ПОМЕНЯТЬ
        alertController.addAction(actionChange)
        // Добавление кнопки ОТМЕНА
        alertController.addAction(actionCancel)
        
        present(alertController, animated: true, completion: nil)
        
    }
    
    //MARK: Кнопка обновить Цену : Action
    @IBAction func updatePriceAction(_ sender: Any) {
        // Создание алерт контроллера
        let alertController = UIAlertController(title: "Смена цены", message: "Укажите ID и новую ценну товара", preferredStyle: .alert)
        
        // Кнопка Изменить и ее функции
        let actionChange = UIAlertAction(title: "Изменить", style: .default) { (action) in
            
            // Переменные для функции
            guard let id = alertController.textFields?[0].text else {return}
            guard let newPriceStr = alertController.textFields?[1].text else {return}
            guard let newPrice = Float(newPriceStr) else {return}
            
            let product = market.servicesAssembly.catalog.find(id)
            
            if product == nil {
                
                // Создание алерт контроллера
                let alertControllerFail = UIAlertController(title: "Ошибка", message: "Под указанным ID не существует продукта", preferredStyle: .alert)
                // Кнопка ОК
                let actionOK = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                // Добавление кнопки ОК
                alertControllerFail.addAction(actionOK)
                
                self.present(alertControllerFail, animated: true, completion: nil)
                
            } else {
                
                // Создание алерт контроллера
                let alertControllerSuccsec = UIAlertController(title: "", message: "", preferredStyle: .alert)
                alertControllerSuccsec.title = "Внимание"
                alertControllerSuccsec.message = "Вы уверены что хотите поменять ценну продукта " + product!.name + " c \(product!.price) на \(newPrice)"
                
                // Кнопка Да
                let actionYes = UIAlertAction(title: "Да", style: .default) { (action) in
                    
                    // Функция смены ценны
                    market.servicesAssembly.catalog.updatePrice(id: id, newPrice: newPrice)
                    
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
        
        // Кнопка Отмены
        let actionCancel = UIAlertAction(title: "Отмена", style: .default, handler: nil)
        // Цвет кнопки Отмена
        actionCancel.setValue(UIColor.red, forKey: "titleTextColor")
        
        // Текстовое поле с ID
        alertController.addTextField { (idTextField) in
            idTextField.placeholder = "ID  продукта"
        }
        // Текстовое поле с новой ценной
        alertController.addTextField { (priceTextField) in
            priceTextField.placeholder = "Новая ценна"
        }
        
        // Добавление кнопки ИЗМЕНИТЬ
        alertController.addAction(actionChange)
        // Добавление кнопки ОТМЕНА
        alertController.addAction(actionCancel)
        
        present(alertController, animated: true, completion: nil)
        
    }
    
    //MARK: Кнопка Удалить Продукт : Action
    @IBAction func deleteProductAction(_ sender: Any) {
        
        // Создание алерт контроллера
        let alertContoller = UIAlertController(title: "", message: "", preferredStyle: .alert)
        alertContoller.title = "Удаление продукта"
        alertContoller.message = "Укажите ID продукта"
        
        // Кнопка Удалить
        let actionDelete = UIAlertAction(title: "Удалить", style: .default) { (action) in
            
            // Переменные для функции
            guard let id = alertContoller.textFields?[0].text else {return}
            // Переменная для проверки
            let product = market.servicesAssembly.catalog.find(id)
            
            if product == nil {
                
                // Создание алерт контроллера
                let alertControllerFail = UIAlertController(title: "", message: "", preferredStyle: .alert)
                alertControllerFail.title = "Ошибка"
                alertControllerFail.message = "Продукта под указанным ID не существует"
                
                // Кнопка ОК
                let actionOK = UIAlertAction(title: "OK", style: .default, handler: nil)
                
                // Добавление кнопки ОК
                alertControllerFail.addAction(actionOK)
                
                self.present(alertControllerFail, animated: true, completion: nil)
                
            } else {
            
                // Создание алерт контроллера
                let alertControllerAccept = UIAlertController(title: "", message: "", preferredStyle: .alert)
                alertControllerAccept.title = "Удаление"
                alertControllerAccept.message = "Вы уверены что хотите удалить продукт " + product!.name
                
                // Кнока Да и ее функции
                let actionYes = UIAlertAction(title: "Да", style: .default) { (action) in
                    
                    //Функция удаления продукта
                    market.servicesAssembly.catalog.removeProduct(id: id)
                    
                }
                // Цвет кнопки Да
                actionYes.setValue(UIColor.red, forKey: "titleTextColor")
                
                // Кнопка Нет
                let actionNo = UIAlertAction(title: "Нет", style: .default, handler: nil)
                
                // Добавление кнопки ДА
                alertControllerAccept.addAction(actionYes)
                // Добавление кнопки НЕТ
                alertControllerAccept.addAction(actionNo)
                
                self.present(alertControllerAccept, animated: true, completion: nil)
            }
            
        }
        // Цвет кнопки Удалить
        actionDelete.setValue(UIColor.red, forKey: "titleTextColor")
        
        // Кнопка Отмены
        let actionCanel = UIAlertAction(title: "Отмена", style: .default, handler: nil)
        
        // Текстовое поле для ID продукт
        alertContoller.addTextField { (idTextField) in
            idTextField.placeholder = "ID удаляемого продукта"
        }
        
        // Добавление кнопки УДАЛИТЬ
        alertContoller.addAction(actionDelete)
        // Добавление кнопки ОТМЕНА
        alertContoller.addAction(actionCanel)
        
        present(alertContoller, animated: true, completion: nil)
    }
    
    // MARK: Кнопка просмотра каталога : Action
    @IBAction func checkCatalogAction(_ sender: Any) {
        
        // Переменная главного сториборда
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        // Ижект нового контроллера
        let vc = storyboard.instantiateViewController(identifier: "TableViewCatalogController") as! TableViewCatalogController
        // Стиль контроллера
        vc.modalPresentationStyle = .currentContext
        
        present(vc, animated: true, completion: nil)
        
    }
    
    
    //MARK: Кнопка Выхода : Action
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
