// =============================================================================
//  Itadaki
//  Copyright Yuichi Nakayasu. All rights reserved.
// =============================================================================
import UIKit

protocol WallpaperPresentable: class {
    
}

protocol WallpaperViewable: class {
    
}

class WallpaperPresenter: WallpaperPresentable {
    
    weak var view: WallpaperViewable!
    
    init(view: WallpaperViewable) {
        self.view = view
    }
}
