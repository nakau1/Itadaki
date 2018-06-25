// =============================================================================
//  Itadaki
//  Copyright Yuichi Nakayasu. All rights reserved.
// =============================================================================
import UIKit

protocol WallpaperAdapterDelegate: class {
    
}

class WallpaperAdapter: NSObject, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    weak var delegate: WallpaperAdapterDelegate!
    
    init(delegate: WallpaperAdapterDelegate) {
        super.init()
        self.delegate = delegate
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! WallpaperAdapterCell
        
        return cell
    }
}

class WallpaperAdapterCell: UICollectionViewCell {
    
}
