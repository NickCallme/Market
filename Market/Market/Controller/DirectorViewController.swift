//
//  DirectorViewController.swift
//  Market
//
//  Created by Nikita Kolmykov on 04.02.2020.
//  Copyright © 2020 Nikita Kolmykov. All rights reserved.
//

import UIKit

class DirectorViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    // MARK: - Кнопка просмотра штата сотрудников : Action
    @IBAction func checkStateAction(_ sender: Any) {
        
        // сториборд
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        // создание контроллера для инжекта
        let vc = storyboard.instantiateViewController(identifier: "TableViewDirectorController") as! TableViewDirectorController
        // стиль контроллера
        vc.modalPresentationStyle = .currentContext
        
        present(vc, animated: true, completion: nil)
        
    }
    
    
    // MARK: - Кнопка добавления сотрудника : Action
    @IBAction func addWorkerAction(_ sender: Any) {
        
        // Создание алерт контроллера
        let alertController = UIAlertController(title: "", message: "", preferredStyle: .alert)
        alertController.title = "Внимание"
        alertController.message = "Извините в данный момент функция не работает"
        
        // Кнока ОК
        let actionOK = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        // Добавление кнопки ОК
        alertController.addAction(actionOK)
        
        present(alertController, animated: true, completion: nil)
        
    }
    
    // MARK: - Кнопка увольнения сотрудника : Action
    @IBAction func deleteWorkerAction(_ sender: Any) {
        
        // Создание алерт контроллера
        let alertController = UIAlertController(title: "", message: "", preferredStyle: .alert)
        alertController.title = "Внимание"
        alertController.message = "Извините в данный момент функция не работает"
        
        // Кнока ОК
        let actionOK = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        // Добавление кнопки ОК
        alertController.addAction(actionOK)
        
        present(alertController, animated: true, completion: nil)
        
    }
    
    // MARK: - Кнопка выхода : Action
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
