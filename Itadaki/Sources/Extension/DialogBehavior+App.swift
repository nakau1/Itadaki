// =============================================================================
//  Itadaki
//  Copyright Yuichi Nakayasu. All rights reserved.
// =============================================================================
import UIKit

extension DialogBehavior {
    
    class var menu: DialogBehavior {
        let behavior = DialogRightDrawBehavior(width: .rightDrawWidth)
        behavior.overlayIsBlur = true
        behavior.overlayBlurEffectStyle = .dark
        return behavior
    }
}

extension DialogRiseupBehavior {
    
}
