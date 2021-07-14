//
//  ViewController.swift
//  Api_GetMoves
//
//  Created by Meruzhan Avetisyan on 06.07.21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var myTableView: UITableView!
    var viewModel = ViewModel()
    var tableData: [MoveResalut] = []
    var page = 1
    var selectid: MoveResalut?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDelegate()
        getMoves(page: self.page)
    }
    func getMoves(page: Int) {
        
        viewModel.getMoves(page: page) { resalut, error in
            
            if error == nil {
                self.tableData += resalut!
                self.myTableView.reloadData()
            } else {
                self.showAllert(message: error!)
            }
        }
    }
    func showAllert(message: String) {
        let allertVC = UIAlertController(title: "OOOPS!!", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        allertVC.addAction(okAction)
        self.present(allertVC, animated: true, completion: nil)
    }
    func configureDelegate() {
        myTableView.delegate = self
        myTableView.dataSource = self
    }
    
}


extension ViewController:  UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = myTableView.dequeueReusableCell(withIdentifier: "MovesTableViewCell", for: indexPath) as! MovesTableViewCell
        
        cell.configureCell(input: tableData[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 240
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        print("last visible cell index = ", self.myTableView.indexPathsForVisibleRows?.last?.row)
        if let lastIndex = self.myTableView.indexPathsForVisibleRows?.last?.row {
            
            if lastIndex >= self.tableData.count - 10 {
                self.page += 1
                self.getMoves(page: self.page)
            }
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectid = tableData[indexPath.row]
        goToNextPage()
    }
    
    func goToNextPage() {
        
        let nextVC = UIStoryboard(name: "MoveHistory", bundle: nil).instantiateViewController(identifier: "HistoryViewController") as? HistoryViewController
        nextVC?.modalPresentationStyle = .fullScreen
        nextVC?.selectid = self.selectid
        
        self.present(nextVC!, animated: true, completion: nil)
    }
}
