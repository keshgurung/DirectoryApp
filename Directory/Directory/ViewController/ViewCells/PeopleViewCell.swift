//
//  PeopleViewCell.swift
//  Directory
//
//  Created by Kesh Gurung on 03/09/2022.
//

import UIKit

class PeopleViewCell: UITableViewCell {
    
    
    
    var peopleVM: PeopleViewModel?
    var index: Int?
    
    static let reuseID = "\(PeopleViewCell.self)"
    
    lazy var PeopleImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .white
        imageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        return imageView
    }()
    
    lazy var NameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.isAccessibilityElement = true
        label.text = "name"
        return label
    }()
    
    lazy var jobLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.isAccessibilityElement = true
        label.text = "title"
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI(){
        self.contentView.addSubview(self.PeopleImageView)
        self.contentView.addSubview(self.NameLabel)
        self.contentView.addSubview(self.jobLabel)
        
       
        
        self.PeopleImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8).isActive = true
        self.PeopleImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8).isActive = true
        self.PeopleImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8).isActive = true
        
        self.PeopleImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        self.PeopleImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
        self.NameLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20).isActive = true
        self.NameLabel.leadingAnchor.constraint(equalTo: self.PeopleImageView.trailingAnchor, constant: 8).isActive = true
        self.NameLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8).isActive = true
        
        self.jobLabel.topAnchor.constraint(equalTo: self.NameLabel.bottomAnchor, constant: 8).isActive = true
        self.jobLabel.leadingAnchor.constraint(equalTo: self.PeopleImageView.trailingAnchor, constant: 8).isActive = true
        self.jobLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8).isActive = true
        
    }
    func configure(peopleVM: PeopleViewModel, index: Int){
        self.peopleVM = peopleVM
        self.index = index
        
        
        self.NameLabel.text = "\(self.peopleVM?.firstName(for: index) ?? "x") \(self.peopleVM?.lastName(for: index) ?? "x")"
        self.jobLabel.text = self.peopleVM?.jobTitle(for: index)
        
        peopleVM.peopleImage(for: index){ imageData in
          
            guard let imageData = imageData else { return }
            DispatchQueue.main.async {
                self.PeopleImageView.image = UIImage(data: imageData)
            }
        }
    }
}
