//
//  AlertExt.swift
//  NASA Picture of the Day
//
//  Created by Elina Mansurova on 2021-01-19.
//

import UIKit

extension UIViewController {
    func showAlert(title: String, message: String, okAction: (() -> Void)?) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alertVC.addAction(okAction)
        present(alertVC, animated: true, completion: nil)
    }
}
