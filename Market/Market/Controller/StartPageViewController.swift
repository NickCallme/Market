//
//  StartPageViewController.swift
//  Market
//
//  Created by Nikita Kolmykov on 04.02.2020.
//  Copyright © 2020 Nikita Kolmykov. All rights reserved.
//

import UIKit

class StartPageViewController: UIViewController {

    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    func action() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "WarehouseViewController") as! WarehouseViewController
        present(vc, animated: true, completion: nil)
    }
    
    func close() {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func enterAction(_ sender: Any) {
        
        // Переменные для функции
        guard let login = loginTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        
        // Получение сотрудника
        let worker = market.servicesAssembly.database.findWorker(login: login, password: password)
        
        if worker != nil {
            
            // Стриание логина и пароля
            loginTextField.text = ""
            passwordTextField.text = ""
            
            switch worker?.position {
            case .director:
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(identifier: "DirectorViewController") as! DirectorViewController
                vc.modalPresentationStyle = .currentContext
                
                present(vc, animated: true, completion: nil)
                
            case .merchandiser:
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(identifier: "CatalogViewController") as! CatalogViewController
                vc.modalPresentationStyle = .currentContext
                
                present(vc, animated: true, completion: nil)
                
            case .storekeeper:
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(identifier: "WarehouseViewController") as! WarehouseViewController
                vc.modalPresentationStyle = .currentContext
                
                present(vc, animated: true, completion: nil)
                
            case .seller:
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(identifier: "CashboxViewController") as! CashboxViewController
                vc.modalPresentationStyle = .currentContext
                
                present(vc, animated: true, completion: nil)
                
            default:
                break
            }
            
        } else {
            
            // Создание алерт контроллера
            let alertControllerFail = UIAlertController(title: "", message: "", preferredStyle: .alert)
            alertControllerFail.title = "Ошибка"
            alertControllerFail.message = "Введены неверные данные"
            
            // Кнопка Ок
            let actionOK = UIAlertAction(title: "OK", style: .default, handler: nil)
            
            // Добавление кнопки ОК
            alertControllerFail.addAction(actionOK)
            
            present(alertControllerFail, animated: true, completion: nil)
            
        }
        
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
