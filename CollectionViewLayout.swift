//
//  CollectionViewLayout.swift
//  UXCardStack
//
//  Created by Michael Nino Evensen on 17/04/16.
//  Copyright © 2016 no.michaelevensen. All rights reserved.
//

import UIKit

/* The heights are declared as constants outside of the class so they can be easily referenced elsewhere */
struct LayoutConstants {
    struct Cell {
        /* The height of a standard cell */
        static let standardHeight: CGFloat = 200
        /* The cell margin */
        static let margin:CGFloat = 10
        /* The overlap value */
        static let overlap:CGFloat = 40
    }
    struct Transform {
        static let threshold: CGFloat = 20
    }
}

class CollectionViewLayout: UICollectionViewLayout {

    /* Cache CollectionView Layout Attributes in array */
    var cache = [UICollectionViewLayoutAttributes]()

    /* Define initial transform matrix */
    var rotationAndPerspectiveTransform:CATransform3D {
        get {
            var transform = CATransform3DIdentity
            transform.m34 = 1.0 / -500
            return transform
        }
    }
    
    /* Returns the width of the collection view */
    var width: CGFloat {
        get {
            return CGRectGetWidth(collectionView!.bounds)
        }
    }
    
    /* Returns the height of the collection view */
    var height: CGFloat {
        get {
            return CGRectGetHeight(collectionView!.bounds)
        }
    }
    
    /* Returns the number of items in the collection view */
    var numberOfItems: Int {
        get {
            return collectionView!.numberOfItemsInSection(0)
        }
    }
    
    override func prepareLayout() {
        cache.removeAll(keepCapacity: false)
        
        // initial
        var frame = CGRectZero
        var y:CGFloat = 0
        
        // standard height
        let standardHeight = LayoutConstants.Cell.standardHeight
        
        // transform threshold
        let threshold = LayoutConstants.Transform.threshold
        
        let margin = LayoutConstants.Cell.margin
        let overlap = LayoutConstants.Cell.overlap
        
        // iterate
        for item in 0..<numberOfItems {
            
            // keep track of indexpath
            let indexPath = NSIndexPath(forItem: item, inSection: 0)
            let attributes = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
            
            // change index
            let height = standardHeight
            
            // set y position
            y = ((height - overlap) * CGFloat(item))
            
            // frame
            frame = CGRect(x: 0, y: y, width: width, height: height)
            frame = CGRectInset(frame, margin, 0)
            
            /* Overlap the cells */
//            if indexPath.item>0 {
//                frame = CGRectInset(frame, 0, -overlap)
//            }
            
            /*
             * Transform
             */
            let offsetY:CGFloat = (collectionView?.contentOffset.y)!
            let ratio = max(0, min(1, (offsetY / CGRectGetHeight(collectionView!.bounds))))
            
            // transform
            let transformValue:CGFloat = ratio * (threshold * 2) - threshold
            attributes.transform3D = CATransform3DRotate(rotationAndPerspectiveTransform, transformValue * CGFloat(M_PI) / 180, 1.0, 0.0, 0.0)
            
            // zIndex
            attributes.zIndex = item
            
            // Set frame
            attributes.frame = frame
            cache.append(attributes)
            y = CGRectGetMaxY(frame)
        }
    }
    
    // MARK: UICollectionViewLayout
    
    /* Return the size of all the content in the collection view */
    override func collectionViewContentSize() -> CGSize {
        let contentHeight = CGFloat(numberOfItems) * (LayoutConstants.Cell.standardHeight - LayoutConstants.Cell.overlap)
        return CGSize(width: width, height: contentHeight)
        
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        
        for attributes in cache {
//            if CGRectIntersectsRect(attributes.frame, rect) {
                layoutAttributes.append(attributes)
//            }

        }
        
        return layoutAttributes
    }
    
    /* Return true so that the layout is continuously invalidated as the user scrolls */
    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        return true
    }
}
