//
//  BounceLayout.swift
//  Bounce CollectionView
//
//  Created by Home on 23/03/2019.
//  Copyright © 2019 SidorYee. All rights reserved.
//

import UIKit

final class BounceLayout: UICollectionViewFlowLayout {
    private var dynamicAnimator: UIDynamicAnimator!
    private var visibleIndexPaths: Set<IndexPath> = []
    private var latestDelta: CGFloat = 0
    
    // MARK:- 초기화
    override init() {
        super.init()
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        self.dynamicAnimator = UIDynamicAnimator(collectionViewLayout: self)
    }
    
    // MARK:- Life Cycle
    deinit {
        dynamicAnimator.removeAllBehaviors()
        visibleIndexPaths.removeAll()
    }
    
    // MARK: - Private
    private var visibleRect: CGRect {
        guard let collectionView = collectionView else { return .zero }
        
        return CGRect(
            x: collectionView.bounds.origin.x, // equivalent to contentOffset.x
            y: collectionView.bounds.origin.y, // equivalent to contentOffset.y
            width: collectionView.frame.size.width,
            height: collectionView.frame.size.height
        )
    }
    
    /// A "disused" behaviour exists within the dynamicAnimator but not the visible rect.
    private func removeDisusedBehaviours(from layoutAttributes: [UICollectionViewLayoutAttributes]) {
        let indexPaths = layoutAttributes.map { $0.indexPath }
        
        dynamicAnimator.behaviors
            .compactMap { $0 as? UIAttachmentBehavior }
            .filter {
                guard let layoutAttributes = $0.items.first as? UICollectionViewLayoutAttributes else { return false }
                return !indexPaths.contains(layoutAttributes.indexPath)
            }
            .enumerated()
            .forEach { index, object in
                dynamicAnimator.removeBehavior(object)
                visibleIndexPaths.remove((object.items.first as! UICollectionViewLayoutAttributes).indexPath)
        }
    }
    
    /// A "new" behaviour is contained within the layoutAttributes array, but not in the visibleIndexPaths.
    private func addNewBehaviours(for layoutAttributes: [UICollectionViewLayoutAttributes]) {
        guard let collectionView = collectionView else { return }
        
        let touchLocation = collectionView.panGestureRecognizer.location(in: collectionView)
        
        layoutAttributes
            .filter {
                !visibleIndexPaths.contains($0.indexPath)
            }
            .forEach { item in
                let center = item.center
                let behaviour = UIAttachmentBehavior(item: item, attachedToAnchor: center)
                behaviour.length = 0
                behaviour.damping = 0.5
                behaviour.frequency = 0.8
                behaviour.frictionTorque = 0.0
                
                if !touchLocation.equalTo(.zero) {
                    let distanceFromTouchY: CGFloat = abs(touchLocation.y - behaviour.anchorPoint.y)
                    let distanceFromTouchX: CGFloat = abs(touchLocation.x - behaviour.anchorPoint.x)
                    let scrollResistance = (distanceFromTouchY + distanceFromTouchX) / 1500
                    guard let item = behaviour.items.first as? UICollectionViewLayoutAttributes else { return }
                    
                    var center = item.center
                    center.y += latestDelta < 0 ? max(latestDelta, latestDelta * scrollResistance) : min(latestDelta, latestDelta * scrollResistance)
                    item.center = center
                }
                
                dynamicAnimator.addBehavior(behaviour)
                visibleIndexPaths.insert(item.indexPath)
        }
    }
    
    override func prepare() {
        super.prepare()
        guard let elementsInVisibleRect = super.layoutAttributesForElements(in: self.visibleRect) else { return }
        
        removeDisusedBehaviours(from: elementsInVisibleRect)
        addNewBehaviours(for: elementsInVisibleRect)
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return self.dynamicAnimator.items(in: rect) as? [UICollectionViewLayoutAttributes]
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return dynamicAnimator.layoutAttributesForCell(at: indexPath)
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        guard let collectionView = collectionView else { return true }
        
        let delta = newBounds.origin.y - collectionView.bounds.origin.y
        let touchLocation = collectionView.panGestureRecognizer.location(in: collectionView)
        latestDelta = delta
        
        dynamicAnimator.behaviors
            .compactMap { $0 as? UIAttachmentBehavior }
            .forEach {
                guard let item = $0.items.first else { return }
                
                let distanceFromTouchY: CGFloat = abs(touchLocation.y - $0.anchorPoint.y)
                let distanceFromTouchX: CGFloat = abs(touchLocation.x - $0.anchorPoint.x)
                let scrollResistance = (distanceFromTouchX + distanceFromTouchY) / 1500
                var center = item.center
                
                center.y += delta > 0 ? min(delta, delta * scrollResistance) : max(delta, delta * scrollResistance)
                item.center = center
                
                dynamicAnimator.updateItem(usingCurrentState: item)
        }
        
        return false
    }
}
