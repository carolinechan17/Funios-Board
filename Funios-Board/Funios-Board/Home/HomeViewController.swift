//
//  HomeViewController.swift
//  Funios-Board
//
//  Created by Ade Dwi Prayitno on 11/08/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var transferButton: UIButton!
    @IBOutlet weak var topupButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        setupLayout()
    }

}


//MARK: - Setup Layout
extension HomeViewController{
    func setupLayout(){
        cardView.layer.cornerRadius = 25
        userProfileImageView.layer.cornerRadius = 15
        
        topupButton
            .imageView?
            .tintColor=UIColor.blue
        
        transferButton
            .imageView?
            .tintColor=UIColor.blue
    }
}
