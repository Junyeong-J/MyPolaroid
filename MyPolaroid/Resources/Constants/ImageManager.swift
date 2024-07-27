//
//  ImageManager.swift
//  MyPolaroid
//
//  Created by 전준영 on 7/27/24.
//

import UIKit
import Kingfisher

final class ImageManager {
    
    static let shared = ImageManager()
    private init() { }
    
    func saveImageFromURLToDocument(imageURL: String, filename: String) {
        guard let url = URL(string: imageURL) else { return }
        
        //Kingfisher의 downloadImage로 URL이미지를 UIImage로 변환시키기위해 사용
        ImageDownloader.default.downloadImage(with: url) { result in
            switch result {
            case .success(let value):
                self.saveImageToDocument(image: value.image, filename: filename)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func saveImageToDocument(image: UIImage, filename: String) {
        guard let documentDirectory = FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask).first else { return }
        
        let fileURL = documentDirectory.appendingPathComponent("\(filename).jpg")
        
        guard let data = image.jpegData(compressionQuality: 0.5) else { return }
        
        do {
            try data.write(to: fileURL)
        } catch {
            print("file save error", error)
        }
    }
    
    func loadImageToDocument(filename: String) -> UIImage? {
        guard let documentDirectory = FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask).first else { return nil }
        
        let fileURL = documentDirectory.appendingPathComponent("\(filename).jpg")
        
        if FileManager.default.fileExists(atPath: fileURL.path) {
            return UIImage(contentsOfFile: fileURL.path)
        } else {
            return UIImage(systemName: "star.fill")
        }
    }
    
    func removeImageFromDocument(filename: String) {
        guard let documentDirectory = FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask).first else { return }
        
        let fileURL = documentDirectory.appendingPathComponent("\(filename).jpg")
        
        if FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                try FileManager.default.removeItem(atPath: fileURL.path)
            } catch {
                print("file remove error", error)
            }
        } else {
            print("file no exist")
        }
    }
}

