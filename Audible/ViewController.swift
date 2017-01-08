//
//  ViewController.swift
//  Audible
//
//  Created by Ronald Hernandez on 1/8/17.
//  Copyright © 2017 Ronaldoh1. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let cellID = "cellID"

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.dataSource = self
        cv.delegate = self
        cv.backgroundColor = .orange
        return cv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        //register cell
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellID)

        view.addSubview(collectionView)
        collectionView.anchorToTop(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
    }


}

extension ViewController : UICollectionViewDelegate {



}

// MARK: UICollectionView Delegate

extension ViewController : UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1

    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
        cell.backgroundColor = .blue

        return cell
    }

}

// MARK: UICollectionViewDelegateFlowLayout


extension ViewController : UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
}

