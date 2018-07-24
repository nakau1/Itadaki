// =============================================================================
//  Itadaki
//  Copyright Yuichi Nakayasu. All rights reserved.
// =============================================================================
import UIKit

@objc protocol ListViewDatasource: NSObjectProtocol {
    
    func numberOfRows(in listView: ListView) -> Int
    
    func listView(_ listView: ListView, viewForRowAt index: Int) -> UIView
}

@objc protocol ListViewDelegate: NSObjectProtocol {
    
    @objc optional func listView(_ listView: ListView, didStartMoveTo index: Int)
    
    @objc optional func listView(_ listView: ListView, didEndMoveAt index: Int)
    
    @objc optional func listView(_ listView: ListView, updateSelectionView view: UIView, selected: Bool)
    
    @objc optional func headerView(in listView: ListView) -> UIView?
    
    @objc optional func footerView(in listView: ListView) -> UIView?
}

class ListView: UIView {

    @IBOutlet weak var dataSource: ListViewDatasource?
    @IBOutlet weak var delegate: ListViewDelegate?
    
    @IBInspectable var visibleCount: Int = 5
    @IBInspectable var animationDuration: Double = 0.1
    
    private(set) var currentIndex = -1
    
    private var positionIndex = 0
    
    private var frames = [CGRect]()
    private var views = [UIView?]()
    private var indecies = [Int]()
    
    private var headerView: UIView!
    private var contentView: UIView!
    private var footerView: UIView!
    
    private var reusableView: UIView?
    
    func reloadData() {
        resetCurrentIndex()
        resetBaseViews()
        resetFrames()
        resetViews()
        resetIndecies()
    }
    
    func selectDown() {
        if currentIndex >= (numberOfRows - 1) { return }
        currentIndex += 1
        
        if positionIndex < (visibleCount - 1) {
            positionIndex += 1
            updateSelectionViews()
        } else {
            let preparingIndex = indeciesDown()
            animateDown() { [unowned self] in
                self.exchangeViewInDown(preparingIndex)
                self.updateSelectionViews()
            }
        }
    }
    
    func selectUp() {
        if currentIndex <= 0 { return }
        currentIndex -= 1
        
        if positionIndex > 0 {
            positionIndex -= 1
            updateSelectionViews()
        } else {
            let preparingIndex = indeciesUp()
            animateUp() { [unowned self] in
                self.exchangeViewInUp(preparingIndex)
                self.updateSelectionViews()
            }
        }
    }
    
    func dequeueReusableView(for: Int) -> UIView? {
        return reusableView
    }
}

extension ListView {
    
    private func indeciesDown() -> Int? {
        let num = numberOfRows
        let min = currentIndex - (visibleCount - 1)
        let max = currentIndex
        indecies = (min...max).compactMap { i -> Int? in
            return i < num ? i : nil
        }
        return max + 1 < num ? max + 1 : nil
    }
    
    private func indeciesUp() -> Int? {
        let num = numberOfRows
        let min = currentIndex
        let max = currentIndex + (visibleCount - 1)
        indecies = (min...max).compactMap { i -> Int? in
            return i < num ? i : nil
        }
        return min - 1 >= 0 ? min - 1 : nil
    }
    
    private func animateDown(finished: @escaping () -> Void) {
        delegate?.listView?(self, didStartMoveTo: currentIndex)
        UIView.animate(
            withDuration: TimeInterval(animationDuration),
            delay: 0,
            options: .curveLinear,
            animations: {
                var frameIndex = -1
                for i in (1..<self.views.count) {
                    frameIndex += 1
                    guard let view = self.views[i] else { continue }
                    view.frame = self.frames[frameIndex]
                }
            },
            completion: { _ in
                finished()
                self.delegate?.listView?(self, didEndMoveAt: self.currentIndex)
            }
        )
    }
    
    private func animateUp(finished: @escaping () -> Void) {
        delegate?.listView?(self, didStartMoveTo: currentIndex)
        UIView.animate(
            withDuration: TimeInterval(animationDuration),
            delay: 0,
            options: .curveLinear,
            animations: {
                var frameIndex = 0
                for i in (0..<(self.views.count - 1)) {
                    frameIndex += 1
                    guard let view = self.views[i] else { continue }
                    view.frame = self.frames[frameIndex]
                }
            },
            completion: { _ in
                finished()
                self.delegate?.listView?(self, didEndMoveAt: self.currentIndex)
            }
        )
    }
    
    private func exchangeViewInDown(_ preparingIndex: Int?) {
        reusableView = views.removeFirst()
        reusableView?.removeFromSuperview()
        
        if let index = preparingIndex, let view = dataSource?.listView(self, viewForRowAt: index) {
            view.frame = frames.last!
            contentView.addSubview(view)
            views.append(view)
            reusableView = nil
        } else {
            views.append(nil)
        }
    }
    
    private func exchangeViewInUp(_ preparingIndex: Int?) {
        reusableView = views.removeLast()
        reusableView?.removeFromSuperview()
        
        if let index = preparingIndex, let view = dataSource?.listView(self, viewForRowAt: index) {
            view.frame = frames.first!
            contentView.addSubview(view)
            views.insert(view, at: 0)
            reusableView = nil
        } else {
            views.insert(nil, at: 0)
        }
    }
    
    private func updateSelectionViews() {
        indecies.enumerated().forEach { i, index in
            let viewIndex = i + 1
            guard let view = views[viewIndex] else { return }
            delegate?.listView?(self, updateSelectionView: view, selected: currentIndex == index)
        }
    }
    
    private func resetCurrentIndex() {
        guard let _ = numberOfVisibleRows else {
            currentIndex = -1
            return
        }
        
        if currentIndex < 0 {
            currentIndex = 0
        }
    }
    
    private func resetBaseViews() {
        removeBaseViews()
        
        contentView = UIView(frame: fillFrame(height: bounds.height))
        contentView.clipsToBounds = true
        
        addSubview(contentView)
    }
    
    private func resetFrames() {
        frames = []
        guard let num = numberOfVisibleRows else { return }
        
        let baseFrame = calculateBaseFrame(dividingNumber: num)
        frames = (-1...num).map { i -> CGRect in
            var frame = baseFrame
            frame.origin.y = CGFloat(i) * baseFrame.height
            return frame
        }
    }
    
    private func resetViews() {
        removeViews()
        guard let num = numberOfVisibleRows else { return }
        
        let max = numberOfRows
        var frameIndex = -1
        
        views = ((currentIndex - 1)...(currentIndex + num)).map { index -> UIView? in
            frameIndex += 1
            
            if !containsRange(index: index, max: max) { return nil }
            guard let view = dataSource?.listView(self, viewForRowAt: index) else { return nil }
            
            view.frame = frames[frameIndex]
            
            contentView.addSubview(view)
            delegate?.listView?(self, updateSelectionView: view, selected: currentIndex == index)
            
            return view
        }
    }
    
    private func resetIndecies() {
        indecies = []
        guard let num = numberOfVisibleRows else { return }
        
        let max = numberOfRows
        
        indecies = (currentIndex..<(currentIndex + num)).compactMap { index -> Int? in
            return containsRange(index: index, max: max) ? index : nil
        }
    }
    
    private var numberOfVisibleRows: Int? {
        return visibleCount > 0 ? visibleCount : nil
    }
    
    private var numberOfRows: Int {
        return dataSource?.numberOfRows(in: self) ?? 0
    }
    
    private func fillFrame(height: CGFloat) -> CGRect {
        return CGRect(origin: .zero, size: CGSize(width: bounds.width, height: height))
    }
    
    private func calculateBaseFrame(dividingNumber num: Int) -> CGRect {
        var ret = contentView.bounds
        ret.size.height /= CGFloat(num)
        return ret
    }
    
    private func containsRange(index: Int, max: Int) -> Bool {
        return 0 <= index && index < max
    }
    
    private func removeBaseViews() {
        [headerView, contentView, footerView].forEach { view in
            if view != nil {
                view?.removeFromSuperview()
            }
        }
        headerView = nil
        contentView = nil
        footerView = nil
    }
    
    private func removeViews() {
        views.forEach { view in
            if view?.superview != nil {
                view?.removeFromSuperview()
            }
        }
        views = []
    }
}
