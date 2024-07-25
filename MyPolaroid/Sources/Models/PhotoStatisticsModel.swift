//
//  PhotoStatisticsModel.swift
//  MyPolaroid
//
//  Created by 전준영 on 7/25/24.
//

import Foundation

struct PhotoStatists: Decodable {
    let id: String
    let downloads: PhotoStatistDownload
    let views: PhotoStatistView
}

struct PhotoStatistDownload: Decodable {
    let totoal: Int
    let historical: DownloadHistorical
}

struct DownloadHistorical: Decodable {
    let values: DownloadHistoricalValues
}

struct DownloadHistoricalValues: Decodable {
    let date: String
    let value: Int
}

struct PhotoStatistView: Decodable {
    let totoal: Int
    let historical: ViewHistorical
}

struct ViewHistorical: Decodable {
    let values: ViewHistoricalValues
}

struct ViewHistoricalValues: Decodable {
    let date: String
    let value: Int
}
