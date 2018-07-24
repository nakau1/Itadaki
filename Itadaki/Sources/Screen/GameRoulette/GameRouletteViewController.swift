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
        messageView.setTexts([
            "「短時間正社員として、6月までの半年で約20人が採用され、働き始めています。",
            "業種としてはサービス業、教育、IT関連などが多いです」",
            "「時短を希望するのは、介護や育児などの事情がある場合に限りません。",
            "フリーランスとの両立やキャリアの継続という観点から、時短正社員を選ぶ人もいます。",
            "例えば、こんなケースがありました。年収が1800万円あった40代の女性が選択したのです。",
            "それで仕事と育児は両立できる半面、出世からは縁遠くなるキャリアコース",
            "いわゆるマミートラックに入ってしまい、やりがいを失ってしまった。",
            "そこで勤めていた会社を退社し、当社のサービスを使って時短正社員として再就職しました。",
            "現在は週5日、午前9時から午後4時までの勤務で、海外進出をサポートするプロジェクトマネジャーをしています。",
            "労働時間が短いので年収は減りましたが、管理職ですし、キャリアも継続できています",
            ])
    }
    
    @IBAction private func didTapStopButton() {
        main.popContents()
    }
}

extension GameRouletteViewController: GameRouletteViewable {
    
}

extension GameRouletteViewController: MessageViewDelegate {

    func messageViewDidShowAllText(in messageView: MessageView) {
        print("messageViewDidShowAllText")
    }
    
    func messageView(_ messageView: MessageView, didShowTextAt arrayIndex: Int) {
        print("didShowTextAt(\(arrayIndex))")
    }
    
    func messageView(_ messageView: MessageView, didAnimating textIndex: Int, arrayIndex: Int) {
        print("didAnimating(\(textIndex)/\(arrayIndex))")
    }
}
