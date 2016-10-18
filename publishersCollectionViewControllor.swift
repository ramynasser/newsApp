//
//  publishersCollectionViewControllor.swift
//  CollectionViewNews
//
//  Created by Mohamed Farouk Code95 on 8/17/16.
//  Copyright © 2016 Mohamed Farouk Code95. All rights reserved.
//

import UIKit


class publishersCollectionViewControllor:UICollectionViewController,CollectionViewCellDelegate
{


     //data source
    let publis = Publishers()
    
    
    private let rightandLeftPadding:CGFloat=32.0
    private let numberOfItemInRow:CGFloat=3.0
    private let heightAdjustment:CGFloat=30.0
    @IBOutlet weak var addButton: UIBarButtonItem!

    
    // MARK: - Delete Items
    
    override func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        addButton.enabled = !editing
        if let indexPaths = collectionView?.indexPathsForVisibleItems() {
            for indexPath in indexPaths {
                collectionView?.deselectItemAtIndexPath(indexPath, animated: false)
                let cell = collectionView?.cellForItemAtIndexPath(indexPath) as! CollectionViewCell
                cell.editing = editing
            }
        }
    }
    func deletePublisher(publisher: Publisher)
    {
        // 1. delete publisher from the data source
        let indexPath = publis.indexPathForPublisher(publisher)
        publis.deleteItemsAtIndexPaths([indexPath])
        
        // 2. collectionView.deleteItemsAtIndexPaths([indexPath])
        UIView.animateWithDuration(1.0, delay: 0, usingSpringWithDamping: 0.75, initialSpringVelocity: 0.0, options: .CurveEaseInOut, animations: { () -> Void in
            self.collectionView?.deleteItemsAtIndexPaths([indexPath])
        }) { (finished) -> Void in
            
        }
    }

    @IBAction func addButtonClicked(sender: AnyObject) {
        // 1. insert a new item into the data source
        let indexPath = publis.indexPathForNewRandomPublisher()
        
        // 2. call insert items at indexPaths
        UIView.animateWithDuration(1.0, delay: 0, usingSpringWithDamping: 0.75, initialSpringVelocity: 0.0, options: .CurveEaseInOut, animations: { () -> Void in
            self.collectionView?.insertItemsAtIndexPaths([indexPath])
        }) { (finished) -> Void in
            
        }
    }
    override func viewDidLoad() {
     super.viewDidLoad()
        
      let width = (CGRectGetWidth((collectionView?.frame)!)-rightandLeftPadding)/numberOfItemInRow
     let layout=collectionViewLayout as! UICollectionViewFlowLayout
      layout.itemSize=CGSizeMake(width, width+heightAdjustment)
        navigationItem.leftBarButtonItem = editButtonItem()

    }

    //UicollectionViewControllor data source
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
       return publis.numberOfSections
    }
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return publis.numberOfPublishersInSection(section)
    }
    
    private struct Stroyboard
    {
        static let cellIdentifier="publishercell"
        static let showsegueIdentifier="showWebView"
    
    }
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
      let cell = collectionView.dequeueReusableCellWithReuseIdentifier(Stroyboard.cellIdentifier, forIndexPath: indexPath) as!  CollectionViewCell
         cell.publisher=publis.publisherForItemAtIndexPath(indexPath)
        cell.editing = editing
        cell.delegate = self
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView
    {
        let headerView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "SectionHeader", forIndexPath: indexPath) as! SectionHeaderView
        
        if let publisher = publis.publisherForItemAtIndexPath(indexPath) {
            headerView.publisher = publisher
        }
        
        return headerView
    }
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let publisher=publis.publisherForItemAtIndexPath(indexPath)
        self.performSegueWithIdentifier(Stroyboard.showsegueIdentifier, sender: publisher)
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == Stroyboard.showsegueIdentifier{
            let webViewController = segue.destinationViewController as! WebViewController
            let publisher = sender as! Publisher
            webViewController.publisher = publisher
        }
    }

    

}