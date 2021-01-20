//
//  SecondViewController.swift
//  NASA Picture of the Day
//
//  Created by Elina Mansurova on 2021-01-19.
//

import UIKit

class SecondViewController: UIViewController {
    
    var pictureOfTheDay: AstronomyPicture?
    
    lazy var textField: UITextView = {
        var textField = UITextView()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont.systemFont(ofSize: 20)
        textField.backgroundColor = .black
        textField.textColor = .white
        return textField
    }()
    
    override func viewDidLoad() {
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.tintColor = .white
        putTextExplanation()
        view.addSubview(textField)
        
        textField.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        textField.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        textField.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    }
    
    func putTextExplanation() {
        if pictureOfTheDay?.explanation != nil {
            DispatchQueue.main.async {
                self.textField.text = self.pictureOfTheDay?.explanation
            }
        } else {
            showAlert(title: "Error", message: "Couldn't upload a text this time (maybe poor connection)", okAction: nil)
        }
    }
}
