//
//  QrViewCashboxController.swift
//  Market
//
//  Created by Nikita Kolmykov on 11.02.2020.
//  Copyright © 2020 Nikita Kolmykov. All rights reserved.
//

import UIKit
import AVFoundation

class QrViewCashboxController: UIViewController , AVCaptureMetadataOutputObjectsDelegate {

    @IBOutlet weak var buttonCancelOutlet : UIButton!
    
    var qrModel = QRCode()
    var videoPreviewLayer = AVCaptureVideoPreviewLayer()
    var qrCodeFrameView = UIView()
    
     override func viewDidLoad() {
         super.viewDidLoad()
         
        // Добавление видео лэйра
        setVideoPreviewLayer()
        // Старт QR сканирования
        qrModel.start(metadataDelegate: self)
         
     }
    
    // MARK: Метод для добавление камеры на вью и обводка QR
    func setVideoPreviewLayer() {
        
        // Добавление сессии к видео лэйру
        videoPreviewLayer.session = qrModel.captureSession
        // Ресайз видео лэйра
        videoPreviewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        // Размер видео лэйра
        videoPreviewLayer.frame = view.frame
        
        // Обводка QR кода
        qrCodeFrameView.layer.borderColor = UIColor.red.cgColor
        qrCodeFrameView.layer.borderWidth = 3
        
        // Добавление лэйра на вью
        view.layer.addSublayer(videoPreviewLayer)
        // Выведение кнопки отмены поверх вью
        view.bringSubviewToFront(buttonCancelOutlet)
        // добавление обводки QR на вью
        view.addSubview(qrCodeFrameView)
        view.bringSubviewToFront(qrCodeFrameView)
        
    }
    
    // MARK: Обработка данных с QR кода
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        
        if metadataObjects.count == 0 {
            
            qrCodeFrameView.frame = CGRect.zero
            
            return
        }
        
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        
        let barCodeObject = videoPreviewLayer.transformedMetadataObject(for: metadataObj)
        qrCodeFrameView.frame = barCodeObject!.bounds
        
        if metadataObj.stringValue != nil {
            
            // Переменные для вариаций
            guard let id = metadataObj.stringValue else {return}
            
            let productCatalog = market.servicesAssembly.catalog.find(id)
            
            if productCatalog != nil {
                
                // Остановка сканирования
                self.qrModel.stop()
                
                // Создание алерт контроллера
                let alertController = UIAlertController(title: "", message: "", preferredStyle: .alert)
                alertController.title = "Количетво"
                alertController.message = "Укажите кол-во " + productCatalog!.name
                
                // Кнопка Добавить
                let actionAdd = UIAlertAction(title: "Добавить", style: .default) { (action) in
                    
                    // Переменные для вариации
                    guard let countStr = alertController.textFields?[0].text else {return}
                    guard let count = Double(countStr) else {return}
                    
                    let productWarehouse = market.servicesAssembly.warehouse.findProduct(id: id)
                    
                    if productWarehouse == nil {
                        
                        // Создать алерт контроллер
                        let alertControllerFail = UIAlertController(title: "", message: "", preferredStyle: .alert)
                        alertControllerFail.title = "Ошибка"
                        alertControllerFail.message = "На складе отсутствует продукт " + productCatalog!.name
                        
                        // Кнопка ОК
                        let actionOK = UIAlertAction(title: "OK", style: .default) { (action) in
                            
                            // Продолжить сканирование
                            self.continueScan()
                            
                        }
                        
                        // Добавление кнопки ОК
                        alertControllerFail.addAction(actionOK)
                        
                        self.present(alertControllerFail, animated: true, completion: nil)
                        
                    } else if count > productWarehouse!.1 {
                        
                        // Создание алерт контроллера
                        let alertControllerFail = UIAlertController(title: "", message: "", preferredStyle: .alert)
                        alertControllerFail.title = "Ошибка"
                        alertControllerFail.message = "На складе отсутсвует указанное количество " + productCatalog!.name
                        
                        // Кнопка ОК
                        let actionOK = UIAlertAction(title: "OK", style: .default) { (action) in
                            
                            // Продолжить сканирование
                            self.continueScan()
                            
                        }
                        
                        // Добавление кнопки ОК
                        alertControllerFail.addAction(actionOK)
                        
                        self.present(alertControllerFail, animated: true, completion: nil)
                        
                    } else {
                        
                        // Добавление позиции в кассу
                        market.cashMachine.addPosition(id: id, count: count)
                       
                        // Обращение к предыдущему контроллеру
                        let preVcOptional = self.presentingViewController as? CashboxViewController
                        guard let preVC = preVcOptional else {return}
                        preVC.tableViewOutlet.reloadData()
                        
                       // Возвращение на кассу
                        self.dismiss(animated: true, completion: nil)
                        
                    }
                    
                }
                // Кнопка Отмена
                let actionCancel = UIAlertAction(title: "Отмена", style: .default) { (action) in
                    
                    // Продолжить сканирование
                    self.continueScan()
                    
                }
                // Цвет кнопки отмена
                actionCancel.setValue(UIColor.red, forKey: "titleTextColor")
                
                // Текстовое поле количества
                alertController.addTextField { (countTextField) in
                    
                    countTextField.placeholder = "Количество"
                    
                }
                
                // Добавление кнопки Добавить
                alertController.addAction(actionAdd)
                // Добавление кнопки Отмена
                alertController.addAction(actionCancel)
                
                present(alertController, animated: true, completion: nil)
                
            }
            
        }
        
    }
    
    // MARK: Функция для продолжения сканирования
    func continueScan() {
        
        qrModel.captureSession.startRunning()
        qrCodeFrameView.frame = CGRect.zero
        
    }
    
    // MARK: - Кнопка отмены : Action
    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
       
}
