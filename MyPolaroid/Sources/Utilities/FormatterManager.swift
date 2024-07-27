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
    
    func formatDateString(_ dateString: String) -> String? {
        let isoFormatter = ISO8601DateFormatter()
        guard let date = isoFormatter.date(from: dateString) else { return nil }
        
        let displayFormatter = DateFormatter()
        displayFormatter.dateFormat = "yyyy년 M월 d일"
        return displayFormatter.string(from: date) + " 게시됨"
    }
    
}
