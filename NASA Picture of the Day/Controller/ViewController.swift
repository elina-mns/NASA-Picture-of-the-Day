//
//  ViewController.swift
//  NASA Picture of the Day
//
//  Created by Elina Mansurova on 2021-01-18.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var imageTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    lazy var imageReceived: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    lazy var goToDescriptionButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .black
        button.setTitle("Description", for: .normal)
        button.addTarget(self, action: #selector(goToDescriptionIsTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        return stackView
    }()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .white
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    var pictureOfTheDay: AstronomyPicture?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        view.addSubview(activityIndicator)
        view.addSubview(imageReceived)
        view.addSubview(imageTitle)
        view.addSubview(goToDescriptionButton)
        navigationController?.isNavigationBarHidden = true
        
        imageReceived.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        imageReceived.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        imageReceived.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageReceived.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        imageTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
        imageTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
        imageTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        
        goToDescriptionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        goToDescriptionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        goToDescriptionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 8).isActive = true
        
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        activityIndicator.startAnimating()
        
        requestImageFile()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    func requestImageFile() {
        AstronomyPictureAPI.requestImageFile { (response, error) in
            guard let responseExpected = response else {
                DispatchQueue.main.async {
                    self.showAlert(title: "Error", message: "Couldn't upload an image this time (maybe poor connection)", okAction: nil)
                }
                return
            }
            self.pictureOfTheDay = responseExpected
            DispatchQueue.main.async {
                self.imageTitle.text = self.pictureOfTheDay?.title
            }
            self.imageReceived.downloaded(from: responseExpected.hdurl) { (image) in
                if image != nil {
                    DispatchQueue.main.async {
                        self.activityIndicator.stopAnimating()
                    }
                } else {
                    DispatchQueue.main.async {
                        self.imageReceived.image = UIImage(named: "error")
                        self.activityIndicator.stopAnimating()
                    }
                }
            }
        }
    }
    
    
    @objc func goToDescriptionIsTapped() {
        let secondViewController = SecondViewController()
        secondViewController.pictureOfTheDay = pictureOfTheDay
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
}


extension UIImageView {
    
    func downloaded(from url: URL, completion: ((UIImage?) -> Void)? = nil) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else {
                completion?(nil)
                return
            }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
                completion?(image)
            }
        }.resume()
    }
}
