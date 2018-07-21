// =============================================================================
//  Itadaki
//  Copyright Yuichi Nakayasu. All rights reserved.
// =============================================================================
import UIKit

class GameRouletteViewController: MainContentsViewController, Notificatable {
    
    private var presenter: GameRoulettePresentable!

    @IBOutlet private weak var stopButton: UIButton!
    @IBOutlet private weak var messageView: MessageView!
    
    class func create() -> MainContentsViewController {
        let vc = instantiate(self)
        vc.presenter = GameRoulettePresenter(view: vc)
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayout() {
        super.viewDidLayout()
        messageView.setText("ディズニーやサンリオ、ドラえもんなど、これまで子ども向けと思われていたような商品アイテムを大人向けに開発し、「オトナ消費」を促してキャラクターグッズの売上を伸ばしてる", animate: true)
    }
    
    @IBAction private func didTapStopButton() {
        main.popContents()
    }
}

extension GameRouletteViewController: GameRouletteViewable {
    
}
