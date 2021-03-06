//
//  UICollectionView+CSExtension.swift
//  CSSwiftExtension
//
//  Created by Chris Hu on 17/1/3.
//  Copyright © 2017年 com.icetime17. All rights reserved.
//

import UIKit

public extension CSSwift where Base: UICollectionView {
    
    // number of all items
    public var numberOfAllItems: Int {
        var itemCount = 0
        for section in 0..<base.numberOfSections {
            itemCount += base.numberOfItems(inSection: section)
        }
        return itemCount
    }
    
    public var firstIndexPath: IndexPath? {
        let numberOfSections = base.numberOfSections
        if numberOfSections == 0 {
            return nil
        }
        
        let numberOfItemsOfFirstSection = base.numberOfItems(inSection: 0)
        if numberOfItemsOfFirstSection == 0 {
            return nil
        }
        
        return IndexPath(item: 0, section: 0)
    }
    
    public var lastIndexPath: IndexPath? {
        let numberOfSections = base.numberOfSections
        if numberOfSections == 0 {
            return nil
        }
        
        let numberOfItemsOfLastSection = base.numberOfItems(inSection: numberOfSections - 1)
        if numberOfItemsOfLastSection == 0 {
            return nil
        }
        
        return IndexPath(item: numberOfItemsOfLastSection - 1, section: numberOfSections - 1)
    }
    
}

public extension CSSwift where Base: UICollectionView {
    public func scrollToFirstCell(scrollPosition: UICollectionViewScrollPosition,
                                 animated: Bool,
                                 completion: CS_ClosureWithBool? = nil) {
        if let firstIndexPath = base.cs.firstIndexPath {
            base.scrollToItem(at: firstIndexPath, at: scrollPosition, animated: animated)
            if let completion = completion {
                completion(true)
            }
        } else {
            if let completion = completion {
                completion(false)
            }
        }
    }
    
    public func scrollToLastCell(scrollPosition: UICollectionViewScrollPosition,
                                 animated: Bool,
                                 completion: CS_ClosureWithBool? = nil) {
        if let lastIndexPath = base.cs.lastIndexPath {
            base.scrollToItem(at: lastIndexPath, at: scrollPosition, animated: animated)
            if let completion = completion {
                completion(true)
            }
        } else {
            if let completion = completion {
                completion(false)
            }
        }
    }
}

// MARK: - reuse
extension UICollectionViewCell: ReusableView {
    
}

extension UICollectionViewCell: NibLoadable {
    
}

public extension UICollectionView {
    
    public func cs_registerNib<T: UICollectionViewCell>(_: T.Type) where T: ReusableView, T: NibLoadable {
        let nib = UINib(nibName: T.nibName, bundle: nil)
        register(nib, forCellWithReuseIdentifier: T.reuseIdentifier)
    }
    
    public func cs_dequeueReusableCell<T: UICollectionViewCell>(forIndexPath indexPath: IndexPath) -> T where T: ReusableView {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("CSSwiftExtension: Could not dequeue cell with identifier \(T.reuseIdentifier)")
        }
        return cell
    }
    
}
