// =============================================================================
//  Itadaki
//  Copyright Yuichi Nakayasu. All rights reserved.
// =============================================================================
import CoreGraphics

extension CGFloat {
    
    /// パーセンテージ (0未満は0, 1以上は1を返す)
    var f: CGFloat {
        if self <= 0 {
            return 0
        } else if 1 <= self {
            return 1
        } else {
            return self
        }
    }
}

extension CGPoint {
    
    /// 簡易イニシャライザ
    ///
    /// - Parameters:
    ///   - x: x座標
    ///   - y: y座標
    init(_ x: CGFloat, _ y: CGFloat) {
        self.init(x: x, y: y)
    }
    
    static func +(lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        return CGPoint(lhs.x + rhs.x, lhs.y + rhs.y)
    }
    
    static func -(lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        return CGPoint(lhs.x - rhs.x, lhs.y - rhs.y)
    }
    
    static func *(lhs: CGPoint, rhs: CGFloat) -> CGPoint {
        return CGPoint(lhs.x * rhs, lhs.y * rhs)
    }
    
    static func /(lhs: CGPoint, rhs: CGFloat) -> CGPoint {
        return CGPoint(lhs.x / rhs, lhs.y / rhs)
    }
}

extension CGSize {
    
    /// 簡易イニシャライザ
    ///
    /// - Parameters:
    ///   - width: 幅
    ///   - height: 高さ
    init(_ width: CGFloat, _ height: CGFloat) {
        self.init(width: width, height: height)
    }
    
    var horizontalHalfSize: CGSize {
        return CGSize(width / 2, height)
    }
    
    var horizontalHalfPoint: CGPoint {
        return CGPoint(width / 2, 0)
    }
    
    func horizontalCenterFrame(of parentSize: CGSize) -> CGRect {
        return CGRect((parentSize.width - self.width) / 2, 0, self.width, self.height)
    }
    
    func centerFrame(of parentSize: CGSize) -> CGRect {
        return CGRect((parentSize.width - self.width) / 2,
                      (parentSize.height - self.height) / 2,
                      self.width,
                      self.height
        )
    }
    
    static func *(lhs: CGSize, rhs: CGFloat) -> CGSize {
        return CGSize(lhs.width * rhs, lhs.height * rhs)
    }
    
    static func /(lhs: CGSize, rhs: CGFloat) -> CGSize {
        return CGSize(lhs.width / rhs, lhs.height / rhs)
    }
}

extension CGRect {
    
    /// 簡易イニシャライザ
    ///
    /// - Parameters:
    ///   - x: x座標
    ///   - y: y座標
    ///   - width: 幅
    ///   - height: 高さ
    init(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) {
        self.init(x: x, y: y, width: width, height: height)
    }
    
    /// 簡易イニシャライザ
    ///
    /// - Parameters:
    ///   - origin: 位置
    ///   - size: サイズ
    init(_ origin: CGPoint, _ size: CGSize) {
        self.init(origin: origin, size: size)
    }
    
    /// 簡易イニシャライザ。位置はCGPoint.zeroが設定される
    ///
    /// - Parameter size: サイズ
    init(_ size: CGSize) {
        self.init(origin: .zero, size: size)
    }
}

extension Int {
    
    /// CGFloatにキャストした値
    var f: CGFloat {
        return CGFloat(self)
    }
}

extension Double {
    
    /// CGFloatにキャストした値
    var f: CGFloat {
        return CGFloat(self)
    }
}

extension Float {
    
    /// CGFloatにキャストした値
    var f: CGFloat {
        return CGFloat(self)
    }
}
