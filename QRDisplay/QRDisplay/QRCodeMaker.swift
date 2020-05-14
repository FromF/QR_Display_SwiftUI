//
//  QRCodeMaker.swift
//  QRDisplay
//
//  Created by 藤 治仁 on 2020/05/14.
//  Copyright © 2020 F-Works. All rights reserved.
//

import UIKit

class QRCodeMaker: NSObject {
    private let correctionTexts = ["L" , "M" , "Q" , "H" ]

    func make(message:String , level:Int) -> UIImage? {
        guard let data = message.data(using: .utf8) else { return nil }

        guard let qr = CIFilter(name: "CIQRCodeGenerator", parameters: ["inputMessage": data, "inputCorrectionLevel": getCorrectionText(index: level)]) else { return nil }
        
        let sizeTransform = CGAffineTransform(scaleX: 10, y: 10)
        
        guard let ciImage = qr.outputImage?.transformed(by: sizeTransform) else { return nil }
        
        guard let cgImage = CIContext().createCGImage(ciImage, from: ciImage.extent) else { return nil }
        
        let image = UIImage(cgImage: cgImage)
        
        return image
    }
    
    func getCorrectionText(index:Int) -> String {
        return correctionTexts[index]
    }

    func getCorrectionCount() -> Int {
        return correctionTexts.count
    }
    
}
