//
//  DotaHeroViewController.swift
//  Funios-Board
//
//  Created by Caroline Chan on 23/09/22.
//

import UIKit

class DotaHeroViewController: UIViewController {

    @IBOutlet weak var dotaHeroTableView: UITableView!
    
    var dotaHeroData: [DotaModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

//MARK: Delegate
extension DotaHeroViewController {
    func setupDelegate() {
        self.dotaHeroTableView.dataSource = self
        self.dotaHeroTableView.delegate = self
    }
}

//MARK: Conform UITableViewDelegate and UITableViewDataSource
extension DotaHeroViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dotaHeroData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
