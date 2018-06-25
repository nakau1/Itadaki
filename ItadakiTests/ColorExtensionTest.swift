// =============================================================================
//  Itadaki
//  Copyright Yuichi Nakayasu. All rights reserved.
// =============================================================================
import Nimble
import Quick
@testable import Itadaki

class ColorExtensionTestSpec: QuickSpec {
    override func spec() {
        describe("Color#Equatable") {
            let color = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1) // #77C344
            it("RGB値による初期化に成功するかどうか") {
                let target = UIColor(rgb: 0x77C344)
                expect(target == color).to(beTrue())
            }
        }
    }
}
