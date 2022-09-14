//
//  PeopleViewController.swift
//  Directory
//
//  Created by Kesh Gurung on 02/09/2022.
//

import UIKit

class PeopleViewController: UIViewController {
    
    lazy var activityIndicator = UIActivityIndicatorView()
    
    let peopleVM = PeopleViewModel(networkManager: NetworkManager())
    
    lazy var peopleTable: UITableView = {
        let table = UITableView(frame: .zero)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        table.delegate = self
        table.register(PeopleViewCell.self, forCellReuseIdentifier: PeopleViewCell.reuseID)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
        showSpinner()
        self.peopleVM.bind {
            DispatchQueue.main.async {
                
                self.peopleTable.reloadData()
                self.stopSpinner()
                
            }
        }
        
        self.peopleVM.getPeople()
    }
    
    private func setUpUI(){
        self.view.backgroundColor = .systemGray5
        self.title = "People"
        self.view.addSubview(self.peopleTable)
        self.peopleTable.bindToSuperView()
        
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


extension PeopleViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return peopleVM.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PeopleViewCell.reuseID, for: indexPath) as? PeopleViewCell else {
            return UITableViewCell()
        }
        cell.configure(peopleVM: peopleVM, index: indexPath.row)
        return cell
    }
}

extension PeopleViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = PeopleDetailViewController(peopleVM: peopleVM, index: indexPath.row)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


