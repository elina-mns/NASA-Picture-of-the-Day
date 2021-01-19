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
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    var pictureOfTheDay: AstronomyPicture?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        view.addSubview(stackView)
        view.addSubview(activityIndicator)
        self.navigationController?.isNavigationBarHidden = true
        
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        
        stackView.addArrangedSubview(imageTitle)
        stackView.addArrangedSubview(imageReceived)
        stackView.addArrangedSubview(goToDescriptionButton)
        
        imageTitle.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3).isActive = true
        
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        activityIndicator.startAnimating()
        
        requestImageFile()
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
            self.imageReceived.downloaded(from: responseExpected.hdurl) { (image) in
                if image != nil {
                    DispatchQueue.main.async {
                        self.activityIndicator.stopAnimating()
                        self.imageTitle.text = self.pictureOfTheDay?.title
                        self.imageTitle.textColor = .white
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
        presentingViewController?.performSegue(withIdentifier: "Description", sender: goToDescriptionButton)
        let secondViewController = SecondViewController()
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
