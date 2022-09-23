//
//  DotaHeroViewController.swift
//  Funios-Board
//
//  Created by Caroline Chan on 23/09/22.
//

import UIKit

class DotaHeroViewController: UIViewController {

    @IBOutlet weak var dotaHeroTableView: UITableView!
    
    var heroData: DotaModel = []
    var dotaServices: DotaServices = DotaServices()
    var storage: UserDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let _ = getDataFromLocal(DotaModel.self, with: "heroData") else {
            Task {
                heroData = await getHeroFromApi() ?? []
                print(heroData)
            }
            return
        }
        
        heroData = getDataFromLocal(DotaModel.self, with: "heroData") ?? []
        print(heroData)
        
        setupDelegate()
    }

}

//MARK: Delegate
extension DotaHeroViewController {
    func setupDelegate() {
        self.dotaHeroTableView.dataSource = self
        self.dotaHeroTableView.delegate = self
        self.dotaHeroTableView.register(UINib(nibName: "DotaHeroTableViewCell", bundle: nil), forCellReuseIdentifier: "DotaCell")
    }
}

//MARK: Fetch data from API
extension DotaHeroViewController {
    func getHeroFromApi() async -> DotaModel?{
        let data = try? await dotaServices.getHero(endPoint: .getHero)
        
        //MARK: After successfully fetched data, set data to local
        setDataToLocal(object: data, with: "heroData")
        return data
    }
}

//MARK: UserDefaults to store data locally
extension DotaHeroViewController {
    func setDataToLocal<T: Codable>(object: T, with key: String, usingEncoder encoder: JSONEncoder = JSONEncoder()) {
        let data = try? encoder.encode(object)
        UserDefaults.standard.set(data, forKey: key)
    }
    
    func getDataFromLocal<T: Codable>(_ type: T.Type, with key: String, usingDecoder decoder: JSONDecoder = JSONDecoder()) -> T? {
        guard let data = UserDefaults.standard.value(forKey: key) as? Data else {return nil}
        return try? decoder.decode(type.self, from: data)
    }
}

//MARK: Conform UITableViewDelegate and UITableViewDataSource
extension DotaHeroViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return heroData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = dotaHeroTableView.dequeueReusableCell(withIdentifier: "DotaCell") as? DotaHeroTableViewCell else {
            return UITableViewCell()
        }
        
        let hero = heroData[indexPath.row]
        cell.setupData(heroName: hero.localizedName)
        return cell
    }
}
