//
//  FormatterManager.swift
//  MyPolaroid
//
//  Created by 전준영 on 7/28/24.
//

import Foundation

class FormatterManager {
    
    static let shared = FormatterManager()
    
    private init() { }
    
    func numberFormatter(_ data: Int) -> String {
        let format = NumberFormatter()
        format.numberStyle = .decimal
        return format.string(from: NSNumber(value: data)) ?? "\(data)"
    }
    
    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter
    }()
    
}
