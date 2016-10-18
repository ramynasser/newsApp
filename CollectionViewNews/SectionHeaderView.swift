//
//  SectionHeaderView.swift
//  CollectionViewNews
//
//  Created by Mohamed Farouk Code95 on 8/18/16.
//  Copyright © 2016 Mohamed Farouk Code95. All rights reserved.
//

import UIKit

class SectionHeaderView: UICollectionReusableView
{
    
    @IBOutlet weak var sectionLabel: UILabel!
    
    var publisher: Publisher? {
        didSet {
            sectionLabel.text = publisher?.section.uppercaseString
        }
    }
    
    
}
