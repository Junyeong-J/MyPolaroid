//
//  ValidationError.swift
//  MyPolaroid
//
//  Created by 전준영 on 7/26/24.
//

import Foundation

enum ValidationError: Error {
    case emptyString
    case trimmingCharacters
}
