//
//  RoomsViewController.swift
//  Directory
//
//  Created by Kesh Gurung on 02/09/2022.
//

import UIKit

class RoomsViewController: UIViewController {
    
    lazy var activityIndicator = UIActivityIndicatorView()

    let roomVM = RoomsViewModel(networkManager: NetworkManager())
    
    lazy var roomsTable: UITableView = {
        let table = UITableView(frame: .zero)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        table.register(RoomsViewCell.self, forCellReuseIdentifier: RoomsViewCell.reuseID)
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
        showSpinner()
        
        self.roomVM.bind {
            DispatchQueue.main.async {
                self.roomsTable.reloadData()
                self.stopSpinner()
            }
        }
        
        self.roomVM.getRooms()
    }
    
    private func setUpUI(){
        self.view.backgroundColor = .systemGray5
        let roomLabel = NSLocalizedString("roomLabel", comment: "title for room")
        self.title = NSLocalizedString(roomLabel, comment: "title for room")
        self.view.addSubview(self.roomsTable)
        self.roomsTable.bindToSuperView()
        
    }
    func showSpinner(){
        
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .large
        activityIndicator.startAnimating()
        self.view.isUserInteractionEnabled = false
        view.addSubview(activityIndicator)
    }
    
    private func stopSpinner(){
        self.activityIndicator.stopAnimating()
        self.view.isUserInteractionEnabled = true
    }
}

extension RoomsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return roomVM.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RoomsViewCell.reuseID, for: indexPath) as? RoomsViewCell else {
            return UITableViewCell()
        }
        cell.configure(roomVM: roomVM, index: indexPath.row)
       return cell
    }
    
    
}

