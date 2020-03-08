//
//  Lipstick.swift
//  Runner
//
//  Created by Gabriel Curinga on 08/03/2020.
//  Copyright © 2020 The Chromium Authors. All rights reserved.
//

import Foundation

extension UIColor {
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255

                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }

        return nil
    }
}

class Lipstick {
    
    let id: String
    let color: String
    let serie: String
    let name: String
    
    init(id: String, color:String, serie:String, name: String) {
        self.color = color
        self.serie = serie
        self.name = name
        self.id = id
    }
    
    
    
}
