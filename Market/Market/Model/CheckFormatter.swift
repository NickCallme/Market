//
//  CheckFormater.swift
//  Shop
//
//  Created by Nikita Kolmykov on 09.01.2020.
//  Copyright © 2020 Nikita Kolmykov. All rights reserved.
//

import Foundation

// MARK: Протокол Форматировщика Чека
protocol CheckFormatter {
    
    // Форматирование по наличной оплате
    func purchaseCash ( number: Int, data: Check ) -> [String]
    
    // Форматирование по безналичной оплате
    func purchaseCashless ( number: Int, data: Check ) -> [String]
    
}

// MARK: Реализация Форматировщика Чека
class CheckFormatterImpl : CheckFormatter {
    
    // Форматирование наличной оплаты
    func purchaseCash(number: Int, data: Check) -> [String] {
        
        var result = [String]()
        //Номер кассовой машины
        result.append( "KKM №" + String(number) )
        //Позиции из чека
        result.append(contentsOf: data.description())
        //Метод покупки
        result.append("Способ оплаты: НАЛИЧНЫМИ")
        //Сумма чека
        result.append( "Итог: " + String(data.total()) )
        //Дата на момент покупки
        result.append( Date().description )
        
        return result
    }
    
    // Форматирование безналичной оплаты
    func purchaseCashless(number: Int, data: Check) -> [String] {
                
        var result = [String]()
        //Номер кассовой машины
        result.append( "KKM №" + String(number) )
        //Позиции из чека
        result.append(contentsOf: data.description())
        //Метод покупки
        result.append("Способ оплаты: БЕЗНАЛИЧНЫЙ")
        //Сумма чека
        result.append( "Итог: " + String(data.total()) )
        //Дата на момент покупки
        result.append( Date().description )
        
        return result
    }
    
    //Конец реализации
}
