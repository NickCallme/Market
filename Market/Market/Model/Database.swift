//
//  Database.swift
//  Shop
//
//  Created by Nikita Kolmykov on 29.12.2019.
//  Copyright © 2019 Nikita Kolmykov. All rights reserved.
//

import Foundation

// MARK: Протокол Базы Данных
protocol Database {
    
    // Добавить данные по кассе
    func addCashbox ( number: Int, data: Check )
    
    // Проверить чеки с кассы за день
    func checkCashboxForDay ( number: Int, day: String) -> [Check]
    
    // Проверить чеки с кассы за период
    func checkCashboxForInterval ( number: Int, from: String, to: String) -> [Check]
    
    // Проверить выручку магазина за день
    func checkAllShopForDay ( day: String ) -> String
    
    // Проверить выручку магазина за период
    func checkAllShopForInterval ( from: String, to: String ) -> String
    
    // Найти работника
    func findWorker( login: String, password: String ) -> Worker?
    
    // Добавить работника
    func addWorker( worker: Worker )
    
    // Вернуть данные работников
    func returnDataWorkers() -> [Worker]
    
    
}

// MARK: Реализация базы данных
class DatabaseImpl : Database {
    
    
    // База данных по кассам [ Дата : [ Номер кассы : [ Чеки ] ] ]
    var dataCashbox = [ String : [ Int : [Check] ] ]()
    
    // База данных сотрудников
    var dataWorkers = [Worker]()
    
    // Текущая дата
    var date = Date().now()
    
    // Найти сотрудника
    func findWorker(login: String, password: String) -> Worker? {
        
        for obj in dataWorkers {
            if obj.firstName == login && obj.password == password {return obj}
        }
        return nil
    }
    
    // Добавить сотрудника
    func addWorker(worker: Worker) {
        dataWorkers.append(worker)
    }
    
    // Вернуть данные сотрудников
    func returnDataWorkers() -> [Worker] {
        return dataWorkers
    }
    
    //Добавление данных с кассы
    func addCashbox(number: Int, data: Check) {
        
        if dataCashbox[date] == nil {
            dataCashbox[date] = [ number : [data] ]
            }
        else {
            if dataCashbox[date]![number] == nil {
                dataCashbox[date]![number] = [ data ]
            } else {
                dataCashbox[date]![number]?.append(data)
            }
        }
    }
    
    // Чеки с кассы за дату
    func checkCashboxForDay(number: Int, day: String) -> [Check] {
        
        var arrayChecks = [Check]()
        
        if dataCashbox[day] != nil {
            if dataCashbox[day]![number] != nil {
                
                for obj in dataCashbox[day]![number]! {
                    arrayChecks.append(obj)
                }
                
            }
            
        }
        
        return arrayChecks
    }
    
    // Чеки с кассы за период
    func checkCashboxForInterval(number: Int, from: String, to: String) -> [Check] {
        
        var arrayChecks = [Check]()
        let arrayDate = Date().arrayDay(from: from, to: to)
        
        for day in arrayDate {
            if dataCashbox[day]![number] != nil {
                arrayChecks.append(contentsOf: dataCashbox[day]![number]!)
            }
        }
        
        return arrayChecks
    }
    
    // Выручка магазина за день
    func checkAllShopForDay(day: String) -> String {
        
        var summ = Float(0)
        
        if dataCashbox[day] != nil {
            
            for cashbox in dataCashbox[day]! {
                for check in cashbox.value {
                    summ += check.total()
                }
            }
            
        }
        
        return String(summ)
    }
    
    // Выручка магазина за период
    func checkAllShopForInterval(from: String, to: String) -> String {
        
        var summ = Float(0)
        let arrayDay = Date().arrayDay(from: from, to: to)
        
        for day in arrayDay {
            for cashbox in dataCashbox[day]! {
                for check in cashbox.value {
                    summ += check.total()
                }
            }
        }
        
        return String(summ)
    }
    
    // Конец реализации
    
    init( workers : [Worker] ) {
        self.dataCashbox = [ String : [ Int : [Check] ] ]()
        self.dataWorkers = [Worker]()
        
        for worker in workers {
            dataWorkers.append(worker)
            }
    }
    
}
