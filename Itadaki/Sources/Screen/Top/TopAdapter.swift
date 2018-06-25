// =============================================================================
//  Itadaki
//  Copyright Yuichi Nakayasu. All rights reserved.
// =============================================================================
import UIKit

protocol TopAdapterDelegate: class {
    
}

class TopAdapter: NSObject, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    weak var delegate: TopAdapterDelegate!
    
    init(delegate: TopAdapterDelegate) {
        super.init()
        self.delegate = delegate
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! TopAdapterCell
        
        return cell
    }
}

class TopAdapterCell: UICollectionViewCell {
    
}
