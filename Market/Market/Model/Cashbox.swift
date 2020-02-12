//
//  CashMachine.swift
//  Shop
//
//  Created by Nikita Kolmykov on 29.12.2019.
//  Copyright © 2019 Nikita Kolmykov. All rights reserved.
//

import Foundation

// MARK: Протокол Кассы
protocol Cashbox {
    
    // Добавление позиции в чек
    func addPosition ( id: String, count: Double )
    
    // Удаление позиции из чека
    func deletePosition ( id: String, count: Double)
    
    // Просмотр Чека
    func returnCheck() -> Check
    
    // Форматирование чека по наличной оплате
    func purchaseCash () -> [String]
    
    // Форматирование чека по безналичной оплате
    func purchaseCashless () -> [String]
    
    // Отмена покупки
    func cancelPurchase () -> Void
    
    // Отчет за смену
    func report () -> [Check]
    
}

// MARK: Реализация Кассы
class CashboxImpl : Cashbox {
    
    // Номер кассы
    var number : Int
    
    // Каталог
    var catalog : Catalog
    
    // База данных
    var database : Database
    
    // Склад
    var warehouse : Warehouse
    
    // Данные кассы
    var data = [Check]()
    
    // Чек кассы
    var check : Check
    
    // Фоматировщик чека
    var checkFMT : CheckFormatter
    
    // Добавить позицию в чек
    func addPosition(id: String, count: Double) {
        guard let product = catalog.find(id) else {return}
        check.add(id: id, product: product, count: count)
    }
    
    // Удалить позицию из чека
    func deletePosition(id: String, count: Double) {
        check.remove(id: id, count: count)
    }
    
    // Просмотр чека
    func returnCheck() -> Check {
        return check
    }
    // Оплата наличными
    func purchaseCash() -> [String] {
        let result = checkFMT.purchaseCash(number: number, data: check)
        database.addCashbox(number: number, data: check)
        warehouse.sell(check: check)
        check.clearData()
        return result
    }
    
    // Оплата безналичная
    func purchaseCashless() -> [String] {
        let result = checkFMT.purchaseCashless(number: number, data: check)
        database.addCashbox(number: number, data: check)
        warehouse.sell(check: check)
        check.clearData()
        return result
    }
    
    // Отмена покупки
    func cancelPurchase() {
        check.clearData()
    }
    
    // Отчет по кассе
    func report() -> [Check] {
        var result = [Check]()
        
        for obj in data {
            result.append(obj)
        }
        
        data = [Check]()
        return result
    }
    
    // Инициализация
    init( number: Int, warehouse: Warehouse, catalog: Catalog, database: Database, check: Check, checkFMT: CheckFormatter) {
        
        self.number = number
        self.warehouse = warehouse
        self.catalog = catalog
        self.database = database
        self.check = check
        self.checkFMT = checkFMT
        
    }
    
    //Конец реализации
}
