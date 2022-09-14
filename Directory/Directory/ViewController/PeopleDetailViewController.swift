//
//  PeopleDetailViewController.swift
//  Directory
//
//  Created by Kesh Gurung on 09/09/2022.
//

import UIKit

class PeopleDetailViewController: UIViewController {

    lazy var topImageView : UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .systemGray
        return imageView
    }()

    lazy var topNameLabel : UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "Name"
        return label
    }()
    
    lazy var topJobLabel : UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "job"
        return label
    }()
    
    lazy var topEmailLabel : UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "email"
        return label
    }()
    
    var peopleVM = PeopleViewModel(networkManager: NetworkManager())
    var index: Int
    
    
    init(peopleVM: PeopleViewModel, index: Int){
        self.peopleVM = peopleVM
        self.index = index
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemGray5
        self.setUpUI()
        tapDetailView()
        
        topNameLabel.isAccessibilityElement = true
        topNameLabel.accessibilityHint = "employer's name"
        
        topJobLabel.isAccessibilityElement = true
        topJobLabel.accessibilityHint = "employer's job title"
        
        topEmailLabel.isAccessibilityElement = true
        topEmailLabel.accessibilityHint = "employer's email address"
    }
    private func tapDetailView(){
        self.topNameLabel.text = "Name: \(self.peopleVM.firstName(for: index) ?? "x") \(self.peopleVM.lastName(for: index) ?? "x")"
        self.topJobLabel.text = "Position: \(self.peopleVM.jobTitle(for: index) ?? "x")"
        self.topEmailLabel.text = "Email: \(self.peopleVM.email(for: index) ?? "x")"
        
        peopleVM.peopleImage(for: index) { imageData in
            guard let imageData = imageData else { return }
            
            DispatchQueue.main.async {
                self.topImageView.image = UIImage(data: imageData)
            }
        }
    }
    
    private func setUpUI(){
        self.view.addSubview(topImageView)
        self.view.addSubview(topNameLabel)
        self.view.addSubview(topJobLabel)
        self.view.addSubview(topEmailLabel)
        
        self.topImageView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        self.topImageView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
        self.topImageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        self.topImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        self.topNameLabel.topAnchor.constraint(equalTo: self.topImageView.bottomAnchor, constant: 12).isActive = true
        self.topNameLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 8).isActive = true
        self.topNameLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -8).isActive = true

        self.topJobLabel.topAnchor.constraint(equalTo: self.topNameLabel.bottomAnchor, constant: 8).isActive = true
        self.topJobLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 8).isActive = true
        self.topJobLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -8).isActive = true
        
        self.topEmailLabel.topAnchor.constraint(equalTo: self.topJobLabel.bottomAnchor, constant: 8).isActive = true
        self.topEmailLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 8).isActive = true
        self.topEmailLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -8).isActive = true
    }
}
