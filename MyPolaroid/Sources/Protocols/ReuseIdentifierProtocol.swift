//
//  ReuseIdentifierProtocol.swift
//  MyPolaroid
//
//  Created by 전준영 on 7/23/24.
//

import UIKit

protocol ReuseIdentifierProtocol {
    
    static var identifier: String { get }
    
}

extension UITableViewCell: ReuseIdentifierProtocol {
    static var identifier: String {
        String(describing: self)
    }
}

extension UICollectionViewCell: ReuseIdentifierProtocol {
    static var identifier: String {
        String(describing: self)
    }
}
