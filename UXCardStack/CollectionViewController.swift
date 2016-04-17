//
//  CollectionViewController.swift
//  UXCardStack
//
//  Created by Michael Nino Evensen on 17/04/16.
//  Copyright © 2016 no.michaelevensen. All rights reserved.
//

import UIKit

private let reuseIdentifier = "CardCell"

class CollectionViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: UICollectionViewDataSource
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
   
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath)
        
//        cell.layer.zPosition = CGFloat(indexPath.item)
//        
//        print(indexPath.item)
        
        return cell
    }
}
