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
        messageView.delegate = self
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

extension GameRouletteViewController: MessageViewDelegate {
    func messageViewDidAnimaing(_ messageView: MessageView, index: Int) {
        print(index)
    }
    
    func messageViewDidShowText(_ messageView: MessageView) {
        messageView.setText("パートタイム派遣など主婦層に特化した人材サービスを提供するビースタイル（東京・新宿）は、専門知識やスキルのある主婦を労働時間が短い", animate: true)
    }
}
