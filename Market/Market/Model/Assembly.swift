//
//  Assembly.swift
//  Market
//
//  Created by Nikita Kolmykov on 04.02.2020.
//  Copyright © 2020 Nikita Kolmykov. All rights reserved.
//

import Foundation


var potato = Product(name: "Каротошка", price: 33.45, unit: .шт)
var fish = Product(name: "Минтай", price: 44.90, unit: .шт)
var bread = Product(name: "Хлеб", price: 30, unit: .шт)

var catalogArr = [ "104": potato , "105" : fish , "106" : bread ]
var warehouseArr : [String:Double] = [ "104": 100 , "105" : 50 , "106" : 200 ]
var workerArr = [
    Worker(firstName: "Dima", secondName: "Novikov", position: .storekeeper, password: "123456789") ,
    Worker(firstName: "Anna", secondName: "Pogodina", position: .merchandiser, password: "123456789"),
    Worker(firstName: "Nikita", secondName: "Kolmykov", position: .seller, password: "123456789"),
    Worker(firstName: "Sasha", secondName: "Belousova", position: .director, password: "123456789")
]

var databaseAssembly = DatabaseImpl(workers: workerArr)
var catalogAssembly = CatalogImpl(data: catalogArr)
var warehouseAssembly = WarehouseImpl(number: 105, database: databaseAssembly, data: warehouseArr)
var checkAssembly = CheckImpl()
var checkFMTassembly = CheckFormatterImpl()

class ServicesAssembly {
    
    var database: Database {
        return databaseAssembly

    }
    
    var catalog: Catalog {
        return catalogAssembly

    }
    
    var warehouse: Warehouse {
        return warehouseAssembly
    }
    
    var check : Check {
        return checkAssembly
    }
    
    var checkFMT: CheckFormatter {
        return checkFMTassembly
    }
    
}


class CashboxAssembly {
    var servicesAssembly = ServicesAssembly()
    
    var cashMachine: Cashbox {
        return CashboxImpl(
        number: 305,
        warehouse: servicesAssembly.warehouse,
        catalog: servicesAssembly.catalog,
        database: servicesAssembly.database,
        check: servicesAssembly.check,
        checkFMT: servicesAssembly.checkFMT)
    }
    
}

var market = CashboxAssembly()
