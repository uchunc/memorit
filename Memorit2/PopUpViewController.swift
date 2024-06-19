//
//  PopUpViewController.swift
//  Memorit2
//
//  Created by 이우천 on 6/19/24.
//

import UIKit

class PopUpViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var record: Record?
    
    private let popupView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPopup()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        setupPopupView()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissPopup))
        view.addGestureRecognizer(tapGesture)
    }
    
    private func setupPopup() {
        guard let record = record else { return }
        imageView.image = record.image
        dateLabel.text = DateFormatter.localizedString(from: record.date, dateStyle: .medium, timeStyle: .short)
        descriptionLabel.text = record.description
    }
    
    private func setupPopupView() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        view.addSubview(popupView)
        
        NSLayoutConstraint.activate([
            popupView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            popupView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            popupView.widthAnchor.constraint(equalToConstant: 300),
            popupView.heightAnchor.constraint(equalToConstant: 400)
        ])
        
        let stackView = UIStackView(arrangedSubviews: [imageView, dateLabel, descriptionLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        
        popupView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: popupView.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: popupView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: popupView.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: popupView.bottomAnchor, constant: -20),
            imageView.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    @objc private func dismissPopup() {
        dismiss(animated: true, completion: nil)
    }
}

