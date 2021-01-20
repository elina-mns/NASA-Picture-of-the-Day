//
//  AstronomyPictureAPI.swift
//  NASA Picture of the Day
//
//  Created by Elina Mansurova on 2021-01-18.
//

import UIKit

class AstronomyPictureAPI {
    
    static let apikey = "zEe8cNKWkoT1kuR4B5LKhZJuzdTfw5cO7kyUJcSw"
    
    enum EndPoints {
        case pictureOfTheDay
        var url: URL {
            return URL(string: self.stringValue)!
        }
        var stringValue: String {
            switch self {
            case .pictureOfTheDay:
                return "https://api.nasa.gov/planetary/apod?api_key=\(AstronomyPictureAPI.apikey)"
            }
        }
    }
    
    class func requestImageFile(completionHandler: @escaping (AstronomyPicture?, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: EndPoints.pictureOfTheDay.url, completionHandler: { (data, response, error) in
            guard let data = data else {
                completionHandler(nil, error)
                return
            }
            let decoder = JSONDecoder()
            let downloadedImageData = try! decoder.decode(AstronomyPicture.self, from: data)
            completionHandler(downloadedImageData, nil)
        })
        task.resume()
    }
}
