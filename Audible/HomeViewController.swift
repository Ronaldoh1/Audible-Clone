//
//  HomeViewController.swift
//  Audible
//
//  Created by Ronald Hernandez on 1/10/17.
//  Copyright © 2017 Ronaldoh1. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpNavigationBar()
        setUpViews()
    }

    fileprivate func setUpNavigationBar() {
        navigationItem.title = "We're logged in"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Sign Out", style: .plain, target: self, action: #selector(handleLogOut))
    }


    @objc fileprivate func handleLogOut() {
        UserDefaults.standard.setIsLoggedIn(value: false)

        let loginController = LoginViewController()
        present(loginController, animated: true, completion: nil)
    }

    fileprivate func setUpViews() {

        let imageView = UIImageView(image: UIImage(named: "home"))
        view.addSubview(imageView)

        _ = imageView.anchor(view.topAnchor, left:view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 64, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }
    
}
