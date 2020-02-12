//
//  Check.swift
//  Shop
//
//  Created by Nikita Kolmykov on 29.12.2019.
//  Copyright © 2019 Nikita Kolmykov. All rights reserved.
//

import Foundation

// MARK: Протокол Чека
protocol Check {
    
    // Данные из чека
    func returnData() -> [ String : ( Product , Double ) ]
    
    // Добавить позицию или обновить
    func add ( id: String, product: Product, count: Double )
    
    // Удалить позицию
    func remove (id: String, count: Double)
    
    // Очистить данные
    func clearData ()
    
    // Сумма чека
    func total () -> Float
    
    // Описание чека
    func description () -> [String]
    
}

// MARK: Реализация Чека
class CheckImpl : Check {
    
    // Данные чека
    var data = [ String : ( Product , Double ) ]()
    
    
    // Данные из чека
    func returnData() -> [ String : ( Product, Double ) ] {
        return data
    }
    
    // Добавить позицию или обновить
    func add( id: String, product: Product, count: Double ) {
        if data[id] == nil {
            data[id] = ( product , count)
        } else {
            data[id] = ( product, data[id]!.1 + count )
        }
    }
    
    // Удалить позицию
    func remove ( id: String , count: Double ) {
        // Проврка на присутствие элемента с данным ID
        if data[id] != nil {
            // Если введеное кол-во больше имеющегося, то удалить объект
            if data[id]!.1 <= count { data.removeValue(forKey: id)}
            // Если нет , то удалить введенное кол-во
            else { data[id]!.1 = data[id]!.1 - count }
        }
    }
    
    // Очистить данные
    func clearData() {
        data.removeAll()
    }
    
    // Сумма чека
    func total() -> Float {
        var summ: Double = 0
        
        for obj in data {
            summ += Double(obj.value.0.price) * obj.value.1
        }
        return Float(summ)
    }
    
    // Описание чека
    func description() -> [String] {
        // Массив позиций
        var arrPosition = [String]()
        
        for obj in data {
            // Позиция
            var position = String()
            // Индефикатор продукта
            position.append(obj.key + " ")
            // Наименнование продукта
            position.append(obj.value.0.name + " ")
            // Цена продукта
            position.append(String(obj.value.0.price) + " * ")
            // Кол-во продукта
            position.append("\(obj.value.1)" + " ")
            // Единица измерения
            position.append("\(obj.value.0.unit)" + " ")
            // Ценна продукта
            position.append(" - " + "\(obj.value.0.price * Float(obj.value.1))")
            // Добавление в массив позиций
            arrPosition.append(position)
        }
        
        return arrPosition
    }
    
    //Конец реализации
}
