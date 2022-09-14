//
//  RoomsViewController.swift
//  Directory
//
//  Created by Kesh Gurung on 02/09/2022.
//

import UIKit

class RoomsViewController: UIViewController {

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
    
        
        self.roomVM.bind {
            DispatchQueue.main.async {
                self.roomsTable.reloadData()
            }
        }
        
        self.roomVM.getRooms()
    }
    
    private func setUpUI(){
        self.view.backgroundColor = .systemGray5
        self.title = "Rooms"
        self.view.addSubview(self.roomsTable)
        self.roomsTable.bindToSuperView()
        
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

