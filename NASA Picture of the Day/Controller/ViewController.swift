//
//  ViewController.swift
//  NASA Picture of the Day
//
//  Created by Elina Mansurova on 2021-01-18.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var imageReceived: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var imageTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        //label.text = AstronomyPicture.title
        label.font = UIFont.systemFont(ofSize: 100)
        return label
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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        view.addSubview(stackView)
        
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        
        stackView.addArrangedSubview(imageReceived)
        stackView.addArrangedSubview(imageTitle)
        stackView.addArrangedSubview(goToDescriptionButton)
    }

    @objc func goToDescriptionIsTapped() {
        
    }
}

