//
//  Catalog.swift
//  Shop
//
//  Created by Nikita Kolmykov on 29.12.2019.
//  Copyright © 2019 Nikita Kolmykov. All rights reserved.
//

import Foundation

// MARK: Протокол Каталога
protocol Catalog {
    
    // Добавление продукта
    func add( id: String , _ product: Product )
    
    // Найти продукт по индификатору
    func find( _ id: String ) -> Product?
    
    // Обновить ценну на продукт по индификатору
    func updatePrice( id: String, newPrice: Float )
    
    // Изменение индификатора продукта
    func changeID( id: String, newID: String )
    
    // Удалить продукт
    func removeProduct( id: String )
    
    // Вернуть данные
    func returnData() -> [ String : Product ]
    
}

// MARK: Реализация Каталога
class CatalogImpl : Catalog {
    
    // Данные каталога
    var data : [ String : Product ]
    
    // Добавление продукта в каталог
    func add(id: String, _ product: Product) {
        data[id] = product
    }
    
    // Найти продукт по индификатору
    func find(_ id: String) -> Product? {
        for obj in data {
            if obj.key == id { return obj.value }
        }
        return nil
    }
    
    // Обновить ценну по индификатору
    func updatePrice(id: String, newPrice: Float) {
        data[id]?.price = newPrice
    }
    
    // Изменение индификатора продукта
    func changeID(id: String, newID: String) {
        
        let product = data[id]
        
        data.removeValue(forKey: id)
        data[newID] = product
        
    }
    
    // Удалить продукт из каталога
    func removeProduct(id: String) {
        data.removeValue(forKey: id )
    }
    
    // Вернуть данные
    func returnData() -> [String : Product] {
        return data
    }
    
    // Инициализация
    init() {
        self.data = [ String : Product]()
    }
    
    init(data: [String : Product ]) {
        self.data = data
    }
// Конец реализации
}
