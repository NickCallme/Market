//
//  extansionDate.swift
//  Shop
//
//  Created by Nikita Kolmykov on 09.01.2020.
//  Copyright © 2020 Nikita Kolmykov. All rights reserved.
//

import Foundation

// MARK: Расширение Даты
extension Date {

    // Перевод строки в тип Дата
    func strToDate (_ stringForDate: String ) -> Date {
        let fmt = DateFormatter()
        fmt.dateFormat = "dd.MM.yyyy"
        
        return fmt.date(from: stringForDate)!
    }
    
    // Перевод даты в тип Строка
    func dateToStr (_ dateForString: Date ) -> String {
        let fmt = DateFormatter()
        fmt.dateFormat = "dd.MM.yyyy"
        
        return fmt.string(from: dateForString)
    }
    
    // Получение массива дат для использования как ключей для базы данных
    func arrayDay( from: String, to: String ) -> [String] {
        
        var arrayDays = [String]()
        
        let fmt = DateFormatter()
        fmt.dateFormat = "dd.MM.yyyy"
        
        var start = fmt.date(from: from)
        let end = fmt.date(from: to)
        
        while start! <= end! {
            arrayDays.append(fmt.string(from: start!))
            start = Calendar.current.date(byAdding: .day, value: 1, to: start!)
        }
        
        return arrayDays
    }
    
    // Получение текущей даты для использования как ключа в базе данных
    func now() -> String {
        
        let fmt = DateFormatter()
        fmt.dateFormat = "dd.MM.yyyy"
        
        return fmt.string( from: Date() )
    }
    
}
