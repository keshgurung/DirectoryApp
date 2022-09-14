//
//  RoomsViewCell.swift
//  Directory
//
//  Created by Kesh Gurung on 03/09/2022
//

import UIKit

class RoomsViewCell: UITableViewCell {
    
    var roomVM: RoomsViewModel?
    var index: Int?
    
    static let reuseID = "\(RoomsViewCell.self)"
    
    lazy var idLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "id"
        return label
    }()
    
    lazy var occupancyLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "occupancy"
        return label
    }()
    
    lazy var occupiedLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "yes"
        return label
    }()
    
    lazy var createdLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "created"
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
        
        
        
        self.contentView.addSubview(self.idLabel)
        self.contentView.addSubview(self.occupancyLabel)
        self.contentView.addSubview(self.occupiedLabel)
        self.contentView.addSubview(self.createdLabel)
        
        
        
        self.idLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10).isActive = true
        self.idLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10).isActive = true
        
        self.occupancyLabel.topAnchor.constraint(equalTo: self.idLabel.bottomAnchor, constant: 10).isActive = true
        self.occupancyLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10).isActive = true
        
        self.occupiedLabel.topAnchor.constraint(equalTo: self.occupancyLabel.bottomAnchor, constant: 10).isActive = true
        self.occupiedLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10).isActive = true
        
        self.createdLabel.topAnchor.constraint(equalTo: self.occupiedLabel.bottomAnchor, constant: 10).isActive = true
        self.createdLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10).isActive = true
        self.createdLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10).isActive = true
    }
    
    func configure(roomVM: RoomsViewModel, index: Int){
        self.roomVM = roomVM
        self.index = index
        
        self.idLabel.text = "ID: \(roomVM.id(for: index) ?? "0")"
        self.occupancyLabel.text = String("Occupancy: \(roomVM.maxOccupancy(for: index) ?? -1)")
        self.occupiedLabel.text = "Occupied: \(roomVM.isOccupied(for: index) ?? false)"
        self.createdLabel.text = "Created At: \(roomVM.createdAt(for: index) ?? "no")"
    }
}

