//
//  MainNavigationController.swift
//  Audible
//
//  Created by Ronald Hernandez on 1/9/17.
//  Copyright © 2017 Ronaldoh1. All rights reserved.
//

import UIKit

class MainNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .red

        if isLoggedIn() {
            let homeViewController = HomeViewController()
            viewControllers = [homeViewController]

        } else {
            perform(#selector(showLoginController), with: nil, afterDelay: 0.01)
        }
    }


    func showLoginController() {
        let loginController = LoginViewController()
        present(loginController, animated: true, completion: nil)
    }

    fileprivate func  isLoggedIn() -> Bool {
        return true
    }
}


class HomeViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        let imageView = UIImageView(image: UIImage(named: "home"))
        view.addSubview(imageView)

        _ = imageView.anchor(view.topAnchor, left:view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 64, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }
}
