//
//  ViewController.swift
//  swift--my-credit
//
//  Created by Сергей Смирнов on 23.05.2021.
//

import UIKit

class CreditsViewController: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let saveContext = (UIApplication.shared.delegate as! AppDelegate).saveContext

    @IBOutlet weak var emptyDataVIew: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    private var credits: [CreditItem]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchCredits()
    }
    
    func fetchCredits() {
        do {
            credits = try context.fetch(CreditItem.fetchRequest())
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.initViews()
            }
        } catch  {
            fatalError(error.localizedDescription)
        }
    }
    
    func initViews() {
        let hasCredits = credits?.count ?? 0 > 0
        
        tableView.isHidden = hasCredits ? false : true
        emptyDataVIew.isHidden = hasCredits ? true : false
    }

}

extension CreditsViewController: UITableViewDelegate {
    
}

extension CreditsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.credits?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CreditTableViewCell.identifier, for: indexPath) as! CreditTableViewCell
        let credit = credits![indexPath.row]
        
        cell.configure(with: credit)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { action, view, completionHandler in
            let creditToRemove = self.credits![indexPath.row]
            self.context.delete(creditToRemove)
            self.saveContext()
            self.fetchCredits()
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CreditTableViewCell.height + CreditTableViewCell.padding
    }
}
