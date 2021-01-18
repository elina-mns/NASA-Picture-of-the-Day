//
//  AstronomyPicture.swift
//  NASA Picture of the Day
//
//  Created by Elina Mansurova on 2021-01-18.
//

import UIKit

struct AstronomyPicture: Codable {
    let explanation: String
    let hdurl: URL
    let mediaType: String
    let title: String
    
    enum CodingKeys: String, CodingKey {
        case explanation
        case hdurl
        case mediaType = "media_type"
        case title
    }
}

