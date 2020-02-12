//
//  Product.swift
//  Shop
//
//  Created by Nikita Kolmykov on 29.12.2019.
//  Copyright © 2019 Nikita Kolmykov. All rights reserved.
//

import Foundation

// MARK: Список единицы измерения
enum Unit {
    case кг
    case шт
}

// MARK: Структура Продукта
struct Product : Hashable {
    
    // Название продукта
    var name: String
    
    // Цена продукта
    var price: Float
    
    // Единица измерения
    var unit: Unit
    
}
