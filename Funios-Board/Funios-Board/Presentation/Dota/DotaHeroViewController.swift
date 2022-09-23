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
    var dotaServices: DotaServices = DotaServices()
    var storage: UserDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if dotaHeroData.isEmpty {
            
        } else {
            
        }
    }

}

//MARK: Delegate
extension DotaHeroViewController {
    func setupDelegate() {
        self.dotaHeroTableView.dataSource = self
        self.dotaHeroTableView.delegate = self
    }
}

//MARK: Fetch data from API
extension DotaHeroViewController {
    func getHeroFromApi() async {
        do {
            let data = try await dotaServices.getHero(endPoint: .getHero)
            
            //MARK: After successfully fetched data, store data into UserDefaults
            
        } catch {
            print(error)
        }
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
