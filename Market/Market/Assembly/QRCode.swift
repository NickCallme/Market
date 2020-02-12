//
//  QRCode.swift
//  Market
//
//  Created by Nikita Kolmykov on 29.01.2020.
//  Copyright © 2020 Nikita Kolmykov. All rights reserved.
//

import Foundation
import AVFoundation

class QRCode {
    
    var captureSession = AVCaptureSession()
    
    let supportedCodeTypes = [AVMetadataObject.ObjectType.upce,
    AVMetadataObject.ObjectType.code39,
    AVMetadataObject.ObjectType.code39Mod43,
    AVMetadataObject.ObjectType.code93,
    AVMetadataObject.ObjectType.code128,
    AVMetadataObject.ObjectType.ean8,
    AVMetadataObject.ObjectType.ean13,
    AVMetadataObject.ObjectType.aztec,
    AVMetadataObject.ObjectType.pdf417,
    AVMetadataObject.ObjectType.itf14,
    AVMetadataObject.ObjectType.dataMatrix,
    AVMetadataObject.ObjectType.interleaved2of5,
    AVMetadataObject.ObjectType.qr]
    
    func start ( metadataDelegate: AVCaptureMetadataOutputObjectsDelegate ) {
        
                guard let captureDevice = AVCaptureDevice.default(for: AVMediaType.video) else {
                    print("Failed to get the camera device")
                    return
                }
                
                do {
                    // Get an instance of the AVCaptureDeviceInput class using the previous device object.
                    let input = try AVCaptureDeviceInput(device: captureDevice)
                    
                    // Set the input device on the capture session.
                    captureSession.addInput(input)
                    
                    // Initialize a AVCaptureMetadataOutput object and set it as the output device to the capture session.
                    let captureMetadataOutput = AVCaptureMetadataOutput()
                    captureSession.addOutput(captureMetadataOutput)
                    
                    // Set delegate and use the default dispatch queue to execute the call back
                    captureMetadataOutput.setMetadataObjectsDelegate(metadataDelegate, queue: DispatchQueue.main)
                    captureMetadataOutput.metadataObjectTypes = supportedCodeTypes
        //            captureMetadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
                    
                } catch {
                    // If any error occurs, simply print it out and don't continue any more.
                    print(error)
                    return
                }
                
                // Initialize the video preview layer and add it as a sublayer to the viewPreview view's layer.
        
        captureSession.startRunning()
     //
    }
    
    func stop () {
        captureSession.stopRunning()
    }
    
    
}
