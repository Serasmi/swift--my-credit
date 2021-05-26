//
//  ViewController.swift
//  swift--my-credit
//
//  Created by Сергей Смирнов on 23.05.2021.
//

import UIKit

class CreditsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var credits: [Credit] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
    }

}

extension CreditsViewController: UITableViewDelegate {
    
}

extension CreditsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.credits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "creditCell", for: indexPath)
        
        return cell
    }
}
