//
//  Lipstick.swift
//  Runner
//
//  Created by Gabriel Curinga on 07/03/2020.
//  Copyright © 2020 The Chromium Authors. All rights reserved.
//

import Foundation

class LipstickDecodable : Decodable {
    let id: String
    let color: UIColor
    let serie: String
    let name: String
    
    enum CodingKeys: CodingKey {
        case color, id, name, serie
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.serie = try container.decode(String.self, forKey: .serie)
        
        // MARK: - UIColor.init(hexString:)
        guard let hex = Int(try container.decode(String.self, forKey: .color).dropFirst(), radix: 16) else {
            let error = DecodingError.Context(codingPath: [CodingKeys.color], debugDescription: "Color string has illegal format.")
            throw DecodingError.typeMismatch(UIColor.self, error)
        }
        let toColorComponent: (Int) -> CGFloat = { return CGFloat($0 & 0xFF) / 255 }
        if #available(iOS 10.0, *) {
            self.color = UIColor(
                displayP3Red: toColorComponent(hex >> 16),
                green: toColorComponent(hex >> 8),
                blue: toColorComponent(hex),
                alpha: 1
            )
        } else {
            // Fallback on earlier versions
            self.color = UIColor.blue
        }
    }
}
