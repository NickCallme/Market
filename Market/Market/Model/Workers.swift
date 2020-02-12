//
//  Workers.swift
//  Market
//
//  Created by Nikita Kolmykov on 09.02.2020.
//  Copyright © 2020 Nikita Kolmykov. All rights reserved.
//

import Foundation

enum Workers {
    case director
    case merchandiser
    case storekeeper
    case seller
}

struct Worker {
    // Имя
    var firstName : String
    // Фамилия
    var secondName : String
    // Должность
    var position : Workers
    // Пароль
    var password : String
    
}

