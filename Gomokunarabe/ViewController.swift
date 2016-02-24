//
//  ViewController.swift
//  Gomokunarabe
//
//  Created by Kodama.Kotaro on 2016/02/24.
//  Copyright © 2016年 Money Forward, Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var resultView: UIView!
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GMKManager.sharedInstance.viewController = self
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UICollectionViewDelegate Protocol
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell:GomokuCell = collectionView.dequeueReusableCellWithReuseIdentifier("Gomoku", forIndexPath: indexPath) as! GomokuCell
        
        cell.row = indexPath.row
        cell.section = indexPath.section
        
        return cell
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 19
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 19;
    }
    
    @IBAction func tapResetButton(sender: AnyObject) {
        GMKManager.sharedInstance.reset()
    }

}

